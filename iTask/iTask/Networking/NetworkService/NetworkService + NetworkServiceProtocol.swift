//
//  NetworkService + NetworkServiceProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

// MARK: - NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
  func request<T: Decodable>(
    request: URLRequest,
    type: T.Type,
    completion: @escaping Completion<T>
  ) {
    DispatchQueue.global(qos: .userInitiated).async {
      self.makeRequest(request: request, type: type) { result in
        DispatchQueue.main.async {
          completion(result)
        }
      }
    }
  }
}

// MARK: - Make Request
private extension NetworkService {
  /// Тип-алиас для ответа сети, содержащий данные и HTTP-ответ.
  typealias NetworkResponse = (data: Data, httpResponse: URLResponse)
  
  /// Выполняет сетевой запрос и обрабатывает его результат.
  /// - Parameters:
  ///   - request: Объект запроса `URLRequest`.
  ///   - type: Тип модели, которая должна быть декодирована из ответа.
  ///   - completion: Завершающий блок с результатом типа `Result<T, Error>`.
  func makeRequest<T: Decodable>(
    request: URLRequest,
    type: T.Type,
    completion: @escaping Completion<T>
  ) {
    session.dataTask(with: request) { data, response, error in
      // Проверка на наличие ошибки в процессе запроса.
      if let error = error {
        completion(.failure(error))
        return
      }
      
      // Проверка валидности данных и ответа.
      guard
        let response = response,
        let data = data else {
        completion(.failure(APIError.responseError))
        return
      }
      
      do {
        // Валидация ответа и декодирование модели.
        let model: T = try self.validateResponse((data, response))
        completion(.success(model))
      } catch {
        completion(.failure(error))
      }
    }.resume() // Запуск задачи.
  }
  
  
  func validateResponse<T: Decodable>(_ response: NetworkResponse) throws -> T {
    guard
      let httpResponse = response.httpResponse as? HTTPURLResponse
    else {
      throw APIError.responseError
    }
    switch httpResponse.statusCode {
    case StatusCode.success:
      return try decodeResponse(data: response.data)
    case StatusCode.clientError:
      throw APIError.clientError
    case StatusCode.serverError:
      throw APIError.serverError
    default:
      throw APIError.unknownError
    }
  }
  
  func decodeResponse<T: Decodable>(data: Data) throws -> T {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  }
}

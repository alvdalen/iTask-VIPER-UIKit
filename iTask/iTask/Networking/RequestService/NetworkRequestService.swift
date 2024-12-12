//
//  NetworkRequestService.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

final class NetworkRequestService {
  // MARK: Private Properties
  private var httpMethod: HTTPMethod { .get }
  private var scheme: API { .https }
  private var host: API { .host }
  private var path: Endpoint { .todos }
  
  // MARK: Private Methods
  /// Подготавливает объект `URL`.
  ///
  /// - Parameters:
  ///   - path: Строка, представляющая путь для формирования URL.
  /// - Returns: Опциональный объект `URL`, сформированный из заданного пути.
  private func prepareURL(
    from path: String
  ) -> URL? {
    let components = prepareURLComponents(from: path)
    let url = components.url
    return url
  }
  
  /// Подготавливает объект `URLComponents`.
  ///
  /// - Parameters:
  ///   - path: Строка, представляющая путь для формирования URL.
  /// - Returns: Объект `URLComponents`, содержащий схему, хост и путь.
  private func prepareURLComponents(
    from path: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    return components
  }
}

// MARK: - NetworkRequestServiceProtocol
extension NetworkRequestService: NetworkRequestServiceProtocol {
  func prepareRequest() throws -> URLRequest {
    guard let url = prepareURL(from: path.rawValue) else {
      throw APIError.URLError
    }
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.rawValue
    return request
  }
}

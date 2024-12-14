//
//  NetworkServiceTests.swift
//  iTaskTests
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import XCTest
@testable import iTask

/// Класс, содержащий тесты для сервиса сетевых запросов.
@available(
  iOS,
  introduced: 13.0,
  deprecated: 13.0,
  message: "Только для моков"
)
final class NetworkServiceTests: XCTestCase {
  // MARK: Private Aliases
  private typealias TestResult = Result<MockModel, Error>
  
  // MARK: Private Properties
  /// URL-запрос для выполнения тестируемого сетевого запроса.
  ///
  /// - Note: Запрос используется во всех тестах,
  /// где требуется выполнить сетевой запрос к моковому серверу.
  private let request = URLRequest(url: NetworkTestsConst.mockURL)
  
  /// Ожидание для асинхронных тестов.
  private lazy var expectation = expectation(
    description: NetworkTestsConst.expectationDescription
  )
  
  /// Моковые данные ответа.
  private var mockData: Data {
    let json = NetworkTestsConst.validJsonString
    return json.data(using: .utf8) ?? Data()
  }
  
  /// Некорректные моковые данные.
  private var invalidMockData: Data {
    let json = NetworkTestsConst.invalidJsonString
    return json.data(using: .utf8) ?? Data()
  }
   
  /// Моковый успешный HTTP-ответ.
  private var mockResponse: HTTPURLResponse {
    createMockResponse(
      statusCode: NetworkTestsConst.successStatusCode
    )
  }
  
  // MARK: Tests
  /// Тест успешного выполнения сетевого запроса с корректным ответом.
  func testRequestSuccess() {
    let mockSession = getMockSession(data: mockData)
    let networkService = NetworkService(session: mockSession)
    networkService.request(request: request, type: MockModel.self) {
      self.handleSuccessRequest($0)
      self.expectation.fulfill()
    }
    waitForExpectation(for: expectation)
  }
  
  /// Тест обработки ошибки декодирования данных.
  func testRequestDecodingError() {
    let mockSession = getMockSession(data: invalidMockData)
    let networkService = NetworkService(session: mockSession)
    networkService.request(request: request, type: MockModel.self) {
      self.handleDecodingError($0)
      self.expectation.fulfill()
    }
    waitForExpectation(for: expectation)
  }
  
  // MARK: Private Methods
  /// Создаёт моковый HTTP-ответ с заданным кодом статуса.
  ///
  /// Этот метод используется для создания фиктивного ответа HTTP с указанным кодом статуса,
  /// который может быть использован в тестах для симуляции различных состояний сетевого запроса.
  ///
  /// - Parameter statusCode: Код статуса, который будет присвоен HTTP-ответу
  /// (например, 200 для успешного запроса или 500 для ошибки сервера).
  /// - Returns: Моковый HTTP-ответ с заданным кодом статуса.
  private func createMockResponse(statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(
      url: NetworkTestsConst.mockURL,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil
    ) ?? HTTPURLResponse()
  }
  
  /// Создаёт моковую сессию с заданными данными.
  ///
  /// Этот метод используется для создания фиктивной сессии,
  /// которая будет возвращать переданные данные и моковый HTTP-ответ.
  ///
  /// - Parameter data: Данные, которые будут возвращены в ответ на
  /// сетевой запрос (может быть `nil` для тестирования без данных).
  /// - Returns: Моковая сессия, настроенная для возврата переданных данных и фиктивного HTTP-ответа.
  private func getMockSession(data: Data?) -> MockURLSession {
    return MockURLSession(
      data: data,
      response: mockResponse,
      error: nil
    )
  }
  
  /// Ожидает выполнения ожидания (expectation) с заданным тайм-аутом.
  ///
  /// Этот метод используется для того, чтобы дождаться выполнения асинхронных операций в тестах.
  /// Он блокирует выполнение до тех пор, пока не выполнится ожидание или не истечёт время тайм-аута.
  ///
  /// - Parameter expectation: Ожидание, которое должно быть выполнено.
  /// - Note: Тайм-аут для ожидания задаётся через `NetworkTestsConst.waitTimeout`.
  /// Если ожидание не выполнится в пределах этого времени, тест завершится с ошибкой.
  private func waitForExpectation(for expectation: XCTestExpectation) {
    wait(
      for: [expectation],
      timeout: NetworkTestsConst.waitTimeout
    )
  }
  
  /// Обрабатывает успешный результат выполнения сетевого запроса.
  ///
  /// Этот метод проверяет, что результат успешного запроса соответствует ожидаемой модели.
  /// Если запрос завершился с ошибкой, тест завершится с неудачей.
  ///
  /// - Parameter result: Результат выполнения сетевого запроса в виде значения типа `Result`.
  /// Может содержать успешную модель или ошибку.
  private func handleSuccessRequest(_ result: TestResult) {
    // Ожидаемое значение модели.
    let expectedModel = MockModel()
    switch result {
    case .success(let model):
      XCTAssertEqual(
        model,
        expectedModel,
        NetworkTestsConst.expectedModelErrorMessage
      )
    case .failure:
      XCTFail(NetworkTestsConst.successExpectedErrorMessage)
    }
  }
  
  /// Обрабатывает ошибку декодирования данных при выполнении сетевого запроса.
  ///
  /// Этот метод проверяет, что ошибка, возникшая при декодировании данных,
  /// является ошибкой типа `DecodingError`. В случае успеха тест завершается с ошибкой,
  /// так как ожидается, что запрос должен был завершиться ошибкой декодирования.
  ///
  /// - Parameter result: Результат выполнения сетевого запроса в виде значения типа `Result`.
  /// Может содержать успешную модель или ошибку.
  private func handleDecodingError(_ result: TestResult) {
    switch result {
    case .success:
      XCTFail(NetworkTestsConst.decodingErrorMessage)
    case .failure(let error):
      XCTAssertTrue(
        error is DecodingError,
        NetworkTestsConst.expectedDecodingErrorMessage
      )
    }
  }
}

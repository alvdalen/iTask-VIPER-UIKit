//
//  MockURLSession.swift
//  iTaskTests
//
//  Created by Адам Мирзаканов on 14.12.2024.
//

import Foundation

@available(
  iOS,
  introduced: 13.0,
  deprecated: 13.0,
  message: "Только для моков"
)

final class MockURLSession: URLSession, @unchecked Sendable {
  // MARK: Aliases
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
  
  // MARK: Private Properties
  private let mockData: Data?
  private let mockResponse: URLResponse?
  private let mockError: Error?
  
  // MARK: Initializers
  init(data: Data?, response: URLResponse?, error: Error?) {
    self.mockData = data
    self.mockResponse = response
    self.mockError = error
  }
  
  // MARK: Internal Methods
  override func dataTask(
    with request: URLRequest,
    completionHandler: @escaping CompletionHandler
  ) -> URLSessionDataTask {
    return MockURLSessionDataTask {
      completionHandler(
        self.mockData,
        self.mockResponse,
        self.mockError
      )
    }
  }
}

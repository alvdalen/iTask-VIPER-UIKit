//
//  MockURLSessionDataTask.swift
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

final class MockURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
  // MARK: Private Properties
  private let completion: () -> Void
  
  // MARK: Initializers
  init(completion: @escaping () -> Void) {
    self.completion = completion
  }
  
  // MARK: Internal Methods
  override func resume() {
    completion()
  }
}

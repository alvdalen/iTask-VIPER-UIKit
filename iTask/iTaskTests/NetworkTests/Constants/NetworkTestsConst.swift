//
//  NetworkTestsConst.swift
//  iTaskTests
//
//  Created by Адам Мирзаканов on 14.12.2024.
//

import Foundation

enum NetworkTestsConst {
  static let mockURL: URL = URL(string: "https://example.com")!
  
  static let validJsonString: String = "{\"id\": 1, \"name\": \"Test\"}"
  static let invalidJsonString: String = "{\"invalid\": \"data\"}"
  
  static let expectationDescription = "Completion should be called"
  static let expectedModelErrorMessage = "Полученная модель не соответствует ожидаемой."
  static let successExpectedErrorMessage = "Ожидался успешный результат, но получена ошибка."
  static let decodingErrorMessage = "Ожидалась ошибка декодирования, но запрос выполнен успешно."
  static let expectedDecodingErrorMessage = "Ошибка должна быть DecodingError."
  
  static let successStatusCode: Int = 200
  
  static let waitTimeout: TimeInterval = 2.0
}

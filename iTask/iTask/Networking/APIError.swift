//
//  APIError.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

/// Перечисление, представляющее возможные ошибки, возникающие при взаимодействии с API.
enum APIError: Error {
  static var statusCode: Int = .zero
  
  /// Ошибка, связанная с некорректным запросом клиента (например, неверные данные или параметры).
  case clientError
  /// Ошибка, возникающая на стороне сервера (например, сбой в обработке запроса).
  case serverError
  /// Неопределённая ошибка, не попадающая в другие категории.
  case unknownError
  /// Ошибка, связанная с некорректным URL или проблемами при выполнении сетевого запроса.
  case URLError
  /// Ошибка, возникающая при декодировании полученных данных (например, несоответствие формата данных).
  case decodingError
  /// Ошибка, возникающая при неверной обработке ответа или отсутствии валидного ответа от сервера.
  case responseError
}

// MARK: - Localized Error
extension APIError: LocalizedError {
  /// Локализованная строка с описанием ошибки в зависимости от её типа.
  var errorDescription: String? {
    switch self {
    case .clientError:
      return NSLocalizedString(Key.contentNotAvailableKey.rawValue, comment: .empty)
    case .serverError:
      return NSLocalizedString(Key.serverIssue.rawValue, comment: .empty)
    case .unknownError:
      return NSLocalizedString(Key.unknownError.rawValue, comment: .empty)
    case .URLError:
      return NSLocalizedString(Key.URLError.rawValue, comment: .empty)
    case .decodingError:
      return NSLocalizedString(Key.decodingError.rawValue, comment: .empty)
    case .responseError:
      return NSLocalizedString(Key.responseError.rawValue, comment: .empty)
    }
  }
}

// MARK: - Localizable Keys
private enum Key: String, CaseIterable {
  case contentNotAvailableKey = "content_not_available_key"
  case serverIssue = "server_issue_key"
  case unknownError = "unknown_error"
  case URLError = "url_error_key"
  case decodingError = "decoding_error_key"
  case responseError = "response_error_key"
}

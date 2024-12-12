//
//  NetworkRequestServiceProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

protocol NetworkRequestServiceProtocol: AnyObject {
  /// Подготавливает объект `URLRequest`.
  func prepareRequest() throws -> URLRequest
}

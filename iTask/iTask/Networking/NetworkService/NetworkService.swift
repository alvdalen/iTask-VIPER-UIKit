//
//  NetworkService.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

/// Служба сети, которая отвечает за выполнение запросов.
final class NetworkService {
  
  let session: URLSession
  
  /// Инициализатор.
  /// - Parameter session: Экземпляр `URLSession`.
  /// По умолчанию используется `URLSession.shared`.
  init(session: URLSession = .shared) {
    self.session = session
  }
}

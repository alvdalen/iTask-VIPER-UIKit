//
//  NetworkServiceProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

/// Замыкание, вызываемое с результатом выполнения: либо данные, либо ошибка.
typealias Completion<T: Decodable> = (Result<T, Error>) -> Void

/// Протокол, определяющий функциональность для выполнения сетевых запросов.
protocol NetworkServiceProtocol: AnyObject {
  /// Выполняет запрос к API и возвращает декодированный ответ через замыкание.
  ///
  /// - Parameters:
  ///   - request: Настроенный объект `URLRequest`, представляющий запрос к API.
  ///   - type: Тип данных, в который будет декодирован ответ API.
  ///   - completion: Замыкание, вызываемое с результатом выполнения: либо данные, либо ошибка.
  func request<T: Decodable>(
    request: URLRequest,
    type: T.Type,
    completion: @escaping Completion<T>
  )
}

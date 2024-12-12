//
//  NetworkService.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

/// Служба сети, которая отвечает за выполнение запросов.
final class NetworkService {
  var session: URLSession {
    .shared
  }
}

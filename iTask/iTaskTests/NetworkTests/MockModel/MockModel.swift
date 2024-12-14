//
//  MockModel.swift
//  iTaskTests
//
//  Created by Адам Мирзаканов on 14.12.2024.
//

/// Модель данных для тестирования.
struct MockModel: Decodable, Equatable {
  var id: Int = 1
  var name: String = "Test"
}

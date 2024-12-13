//
//  String + Extension.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

extension String {
  /// Возвращает пустую строку.
  static var empty: String {
    return String()
  }
  
  /// Преобразует строку в дату и возвращает строку с заданным стилем.
  /// - Parameter style: Стиль форматирования даты.
  /// - Returns: Строка, представляющая дату в заданном формате.
  func toLongDate(style: DateFormatter.Style) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [
      .withInternetDateTime,
      .withFractionalSeconds
    ]
    guard let date = isoFormatter.date(from: self) else {
      // Возвращаем текущую дату, если строка не является корректной датой
      return Date().toLongDateString(style: style)
    }
    let displayFormatter = DateFormatter()
    displayFormatter.dateStyle = style
    return displayFormatter.string(from: date)
  }
}

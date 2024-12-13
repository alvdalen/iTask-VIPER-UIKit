//
//  Date + Extension.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

extension Date {
  /// Расширение для объекта `Date`, добавляющее метод для форматирования даты в строку.
  /// - Parameter style: Стиль форматирования даты (например, `.long`).
  /// - Returns: Строка, представляющая дату в заданном формате.
  func toLongDateString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
}

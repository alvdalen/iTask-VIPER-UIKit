//
//  String + Extension.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

extension String {
  static var empty: String {
    return String()
  }
  
  func toLongDate(style: DateFormatter.Style) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [
      .withInternetDateTime,
      .withFractionalSeconds
    ]
    guard let date = isoFormatter.date(from: self) else {
      return Date().toLongDateString(style: style)
    }
    let displayFormatter = DateFormatter()
    displayFormatter.dateStyle = style
    return displayFormatter.string(from: date)
  }
}

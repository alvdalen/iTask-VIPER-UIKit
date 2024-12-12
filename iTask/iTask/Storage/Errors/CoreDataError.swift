//
//  CoreDataError.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

/// Ошибки Core Data
enum CoreDataError: Error {
  case saveError(String)
  case fetchError(String)
  case updateError(String)
  case deleteError(String)
  
  var localizedDescription: String {
    switch self {
    case
        .saveError(let message),
        .fetchError(let message),
        .updateError(let message),
        .deleteError(let message):
      return message
    }
  }
}

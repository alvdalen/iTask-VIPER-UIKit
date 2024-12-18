//
//  ErrorMessage.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

/// Перечисление сообщений об ошибках для различных случаев в приложении.
enum ErrorMessage {
  /// Сообщение об ошибке, если не реализован инициализатор init(coder:).
  static var initCoderNotImplementedError: String {
    "init(coder:) has not been implemented"
  }
  
  /// Сообщение об ошибке, если подкласс не переопределил метод для регистрации ячеек.
  static var mustOverrideCellRegister: String {
    "Subclasses must override cellRegister() to register cells."
  }
  
  // MARK: ViewLoadable
  /// Сообщение об ошибке, если ожидаемый тип представления не совпадает с фактическим типом.
  static var errorTemplate: String {
    "Expected view to be of type %@ but got %@ instead"
  }
  
  // MARK: Core Data
  /// Сообщение об ошибке при попытке извлечь объекты из Core Data.
  static var fetchObjectsError: String {
    "Failed to fetch objects of type %@: %@"
  }
  
  /// Сообщение об ошибке при попытке обновить объект в Core Data.
  static var updateObjectsError: String {
    "Failed to update object of type %@: %@"
  }
  
  /// Сообщение об ошибке при попытке удалить объект из Core Data.
  static var deleteObjectsError: String {
    "Failed to delete object of type %@: %@"
  }
  
  /// Сообщение об ошибке при сохранении контекста Core Data.
  static var saveContextError: String {
    "Failed to save context %@:"
  }
}

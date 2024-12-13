//
//  CoreDataManager.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import CoreData

/// Менеджер для работы с Core Data
final class CoreDataManager {
  // MARK: Private Properties
  /// Название модели Core Data.
  private let modelName: String
  
  // MARK: Internal Properties
  /// Дескриптор для сортировки данных по дате.
  let sortDescriptor = NSSortDescriptor(key: CoreDataConst.date, ascending: false)
  
  /// Контейнер для управления Core Data.
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: modelName)
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Unresolved error \(error)")
      }
    }
    return container
  }()
  
  // MARK: Initializers
  /// Инициализатор для создания экземпляра CoreDataManager.
  /// - Parameter modelName: Название модели Core Data.
  init(modelName: String) {
    self.modelName = modelName
  }
  
  // MARK: Internal Methods
  /// Сохраняет изменения в текущем контексте Core Data.
  /// - Throws: Ошибка сохранения данных в случае неудачи.
  func saveContext() throws {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        throw CoreDataError.saveError(
          errorMessage(
            errorMessage: ErrorMessage.saveContextError,
            error: error
          )
        )
      }
    }
  }
  
  /// Форматирует сообщение об ошибке для логирования или отображения.
  /// - Parameters:
  ///   - errorMessage: Текст сообщения об ошибке.
  ///   - type: Тип данных, связанный с ошибкой (опционально).
  ///   - error: Объект ошибки.
  /// - Returns: Отформатированная строка с описанием ошибки.
  func errorMessage(
    errorMessage: String,
    type: Any? = nil,
    error: Error
  ) -> String {
    String(
      format: errorMessage,
      String(describing: type),
      error.localizedDescription
    )
  }
}

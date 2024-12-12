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
  private let modelName: String
  
  // MARK: Internal Properties
  let sortDescriptor = NSSortDescriptor(key: CoreDataConst.date, ascending: false)
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
  init(modelName: String) {
    self.modelName = modelName
  }
  
  // MARK: Internal Methods
  /// Сохранение контекста
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

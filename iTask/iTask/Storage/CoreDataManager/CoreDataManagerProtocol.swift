//
//  CoreDataManagerProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import CoreData

protocol CoreDataManagerProtocol: AnyObject {
  /// Контекст.
  var context: NSManagedObjectContext { get }
  
  /// Получение объектов.
  func fetchObjects<T: NSManagedObject>(ofType type: T.Type) throws -> [T]
  
  /// Добавление объекта.
  func addObject<T: NSManagedObject>(
    ofType type: T.Type,
    configure: (T) -> Void
  ) throws
  
  /// Обновление объекта.
  func updateObject<T: NSManagedObject>(
    ofType type: T.Type,
    predicate: NSPredicate,
    configure: (T) -> Void
  ) throws
  
  /// Удаление объекта.
  func deleteObject<T: NSManagedObject>(
    ofType type: T.Type,
    predicate: NSPredicate
  ) throws
}

//
//  CoreDataManagerProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import CoreData

/// Протокол для управления данными с использованием Core Data.
protocol CoreDataManagerProtocol: AnyObject {
  /// Контекст управления объектами Core Data.
  var context: NSManagedObjectContext { get }
  
  /// Получение объектов указанного типа из Core Data.
  /// - Parameter type: Тип объектов, которые нужно получить.
  /// - Returns: Массив объектов указанного типа.
  /// - Throws: Ошибка, возникающая при выполнении запроса.
  func fetchObjects<T: NSManagedObject>(ofType type: T.Type) throws -> [T]
  
  /// Добавление нового объекта в Core Data.
  /// - Parameters:
  ///   - type: Тип добавляемого объекта.
  ///   - configure: Замыкание для настройки объекта перед сохранением.
  /// - Throws: Ошибка, возникающая при сохранении объекта.
  func addObject<T: NSManagedObject>(
    ofType type: T.Type,
    configure: (T) -> Void
  ) throws
  
  /// Обновление существующего объекта в Core Data.
  /// - Parameters:
  ///   - type: Тип объекта для обновления.
  ///   - predicate: Условие для поиска объекта.
  ///   - configure: Замыкание для обновления свойств объекта.
  /// - Throws: Ошибка, возникающая при выполнении операции.
  func updateObject<T: NSManagedObject>(
    ofType type: T.Type,
    predicate: NSPredicate,
    configure: (T) -> Void
  ) throws
  
  /// Удаление объекта из Core Data.
  /// - Parameters:
  ///   - type: Тип объекта для удаления.
  ///   - predicate: Условие для поиска объекта.
  /// - Throws: Ошибка, возникающая при удалении объекта.
  func deleteObject<T: NSManagedObject>(
    ofType type: T.Type,
    predicate: NSPredicate
  ) throws
}

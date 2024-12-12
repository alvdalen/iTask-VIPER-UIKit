//
//  TodoEntity+CoreDataProperties.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//
//

import CoreData

public typealias FetchRequest = NSFetchRequest<TodoEntity>

extension TodoEntity {
  // MARK: Public Properties
  @NSManaged public var id: String?
  @NSManaged public var title: String?
  @NSManaged public var body: String?
  @NSManaged public var date: String?
  @NSManaged public var completed: Bool
  
  // MARK: Public Class Func
  @nonobjc public class func fetchRequest() -> FetchRequest {
    return FetchRequest(entityName: Const.entityName)
  }
}

// MARK: - Identifiable
extension TodoEntity: Identifiable { }

// MARK: - Constants
private enum Const {
  static let entityName: String = "TodoEntity"
}

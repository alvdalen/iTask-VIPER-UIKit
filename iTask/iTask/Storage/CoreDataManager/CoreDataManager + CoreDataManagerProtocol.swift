//
//  CoreDataManager + CoreDataManagerProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import CoreData

extension CoreDataManager: CoreDataManagerProtocol {
  // MARK: Properties
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: Methods
  func fetchObjects<T: NSManagedObject>(
    ofType type: T.Type
  ) throws -> [T] {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<T>(entityName: entityName)
    fetchRequest.sortDescriptors = [sortDescriptor]
    do {
      return try context.fetch(fetchRequest)
    } catch {
      throw CoreDataError.fetchError(
        errorMessage(
          errorMessage: ErrorMessage.fetchObjectsError,
          type: entityName,
          error: error
        )
      )
    }
  }
  
  func addObject<T: NSManagedObject>(
    ofType type: T.Type,
    configure: (T) -> Void
  ) throws {
    let object = T(context: context)
    configure(object)
    try saveContext()
  }
  
  func updateObject<T: NSManagedObject>(
    ofType type: T.Type,
    predicate: NSPredicate,
    configure: (T) -> Void
  ) throws {
    let fetchRequest = T.fetchRequest()
    fetchRequest.predicate = predicate
    
    do {
      if let results = try context.fetch(fetchRequest) as? [T],
         let object = results.first {
        configure(object)
        try saveContext()
      }
    } catch {
      throw CoreDataError.updateError(
        errorMessage(
          errorMessage: ErrorMessage.updateObjectsError,
          type: T.self,
          error: error
        )
      )
    }
  }
  
  func deleteObject<T: NSManagedObject>(
    ofType type: T.Type,
    predicate: NSPredicate
  ) throws {
    let fetchRequest = T.fetchRequest()
    fetchRequest.predicate = predicate
    
    do {
      if let results = try context.fetch(fetchRequest) as? [T],
         let object = results.first {
        context.delete(object)
        try saveContext()
      }
    } catch {
      throw CoreDataError.deleteError(
        errorMessage(
          errorMessage: ErrorMessage.deleteObjectsError,
          type: T.self,
          error: error
        )
      )
    }
  }
}

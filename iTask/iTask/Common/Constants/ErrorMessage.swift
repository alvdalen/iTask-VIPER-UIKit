//
//  ErrorMessage.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

enum ErrorMessage {
  // MARK: ViewLoadable
  static var initCoderNotImplementedError: String {
    "init(coder:) has not been implemented"
  }
  
  static var mustOverrideCellRegister: String {
    "Subclasses must override cellRegister() to register cells."
  }
  
  static var errorTemplate: String {
    "Expected view to be of type %@ but got %@ instead"
  }
  
  // MARK: Core Data
  static var fetchObjectsError: String {
    "Failed to fetch objects of type %@: %@"
  }
  
  static var updateObjectsError: String {
    "Failed to update object of type %@: %@"
  }
  
  static var deleteObjectsError: String {
    "Failed to delete object of type %@: %@"
  }
  
  static var saveContextError: String {
    "Failed to save context %@:"
  }
}

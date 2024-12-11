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
}

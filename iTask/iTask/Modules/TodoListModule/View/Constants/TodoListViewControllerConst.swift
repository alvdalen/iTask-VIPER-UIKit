//
//  TodoListViewControllerConst.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

enum TodoListViewControllerConst {
  static let editIcon = UIImage(systemName: "square.and.pencil")
  static let shareIcon = UIImage(systemName: "square.and.arrow.up")
  static let deleteIcon = UIImage(systemName: "trash")
  static let rowHeight: CGFloat = 140.0
  
  // Localizable
  static var navigationItemTitleText: String {
    Key.tasksKey.localizeString()
  }
  
  static var contextMenuEditTitleText: String {
    Key.editKey.localizeString()
  }
  
  static var contextMenuShareTitleText: String {
    Key.shareKey.localizeString()
  }
  
  static var contextMenuDeleteTitleText: String {
    Key.deleteKey.localizeString()
  }
  
  static var showErrorTitleText: String {
    Key.errorKey.localizeString()
  }
  
  static var showErrorOkText: String {
    Key.okKey.localizeString()
  }
  
  static var tabBarTaskCountTitleText: String {
    Key.tasksCountKey.localizeString()
  }
  
  static var addNavTitleText: String {
    Key.addNavTitleKey.localizeString()
  }
  
  static var editNavTitleText: String {
    Key.editNavTitleKey.localizeString()
  }
}

// MARK: - Localizable Keys
private enum Key: String, CaseIterable {
  case tasksKey = "tasks_key"
  case editKey = "edit_key"
  case shareKey = "share_key"
  case deleteKey = "delete_key"
  case errorKey = "error_key"
  case okKey = "ok_key"
  case tasksCountKey = "tasks_count_key"
  case addNavTitleKey = "add_nav_title_key"
  case editNavTitleKey = "edit_nav_title_key"
  
  func localizeString() -> String {
    NSLocalizedString(self.rawValue, comment: .empty )
  }
}

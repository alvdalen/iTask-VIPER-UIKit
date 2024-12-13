//
//  TodoDetailViewControllerRootViewConst.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

enum TodoDetailViewControllerRootViewConst {
  static let dateFont: UIFont = .systemFont(ofSize: 15.0, weight: .medium)
  static let taskHeaderTextViewFont: UIFont = .systemFont(ofSize: 40.0, weight: .black)
  static let taskBodyTextViewFont: UIFont = .systemFont(ofSize: 18.0)
  static let saveButtonFont: UIFont = .systemFont(ofSize: 18.0)
  
  static let dateLabelColor: UIColor = .systemGray
  static let lineColor: UIColor = .systemGray
  static let saveButtonTitleColor: UIColor = .systemBackground
  static let deleteButtonColor: UIColor = .systemRed
  
  static let pressingSaveButtonScale: CGFloat = 0.8
  static let defaultSaveButtonScale: CGFloat = 1.0
  static let duration: CGFloat = 0.08
  
  static let saveButtonCornerRadius: CGFloat = saveButtonHeight / 2
  static let saveButtonHeight: CGFloat = 40.0
  
  static let mainStackViewSpacing: CGFloat = 16.0
  static let dateStackViewSpacing: CGFloat = 8.0
  static let mainStackViewPadding: CGFloat = 16.0
  static let lineHeight: CGFloat = 1.0
  static let stackViewTopInset: CGFloat = 15.0
  static let stackViewHorizontalInset: CGFloat = 20.0
  static let stackViewWidthAdjustment: CGFloat = -40.0
  static let iconSize: CGFloat = 21.0
  static let taskTitleTextViewStartHeight: CGFloat = 100.0
  
  static let inactiveButtonAlpha: CGFloat = 0.3
  static let activeButtonAlpha: CGFloat = 1.0
  
  static let saveButtonAnimateDuration: TimeInterval = 0.3
  
  static let dateIcon = UIImage(systemName: "calendar")
  static let deleteButtonIcon = UIImage(systemName: "trash.fill")
  
  // Localizable
  static var saveButtonTitle: String {
    Key.saveButtonTitleKey.localizeString()
  }
  
  static var taskTitlePlaceholderText: String {
    Key.taskTitlePlaceholderKey.localizeString()
  }
  
  static var taskBodyPlaceholderText: String {
    Key.taskBodyPlaceholderKey.localizeString()
  }
}

// MARK: - Localizable Keys
private enum Key: String, CaseIterable {
  case taskTitlePlaceholderKey = "task_title_placeholder_key"
  case taskBodyPlaceholderKey = "task_body_placeholder_key"
  case saveButtonTitleKey = "save_button_title_key"
  
  func localizeString() -> String {
    NSLocalizedString(self.rawValue, comment: .empty )
  }
}

//
//  TodoListTableViewCellRootViewConst.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

enum TodoListTableViewCellRootViewConst {
  static let uncheckedCircleIcon = UIImage(systemName: "circle")
  static let checkedCircleIcon = UIImage(systemName: "checkmark.circle")
  
  static let pressingStateButtonScale: CGFloat = 1.1
  static let stateButtonScale: CGFloat = 1.5
  static let duration: CGFloat = 0.08
  
  static let defaultPadding: CGFloat = 20.0
  static let halfDefaultPadding: CGFloat = defaultPadding / 2
  static let minPadding: CGFloat = halfDefaultPadding / 2
  
  static let descriptionNumberOfLines: Int = 2
  
  static let titleFont: UIFont = .systemFont(ofSize: 22.0, weight: .bold)
  static let dateFont: UIFont = .systemFont(ofSize: 15)
  static let taskBodyFont: UIFont = .systemFont(ofSize: 18)
  
  static let uncheckedColor: UIColor = .systemGray3
  static let dateLabelColor: UIColor = .systemGray
  static let normalTextColor: UIColor = .label
}

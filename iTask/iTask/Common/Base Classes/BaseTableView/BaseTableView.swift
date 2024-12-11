//
//  BaseTableView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

class BaseTableView: UITableView {
  // MARK: Initializers
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  /// Подклассы должны переопределять этот метод.
  func cellRegister() {
    fatalError(ErrorMessage.mustOverrideCellRegister)
  }
}

//
//  BaseRootView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

class BaseRootView: UIView {
  // MARK: Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  /// Подклассы должны переопределять этот метод.
  func setupViews() {
    backgroundColor = .systemBackground
  }
}

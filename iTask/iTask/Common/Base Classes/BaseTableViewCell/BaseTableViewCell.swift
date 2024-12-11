//
//  BaseTableViewCell.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

class BaseTableViewCell<ViewType: UIView>: UITableViewCell {
  
  typealias RootView = ViewType
  
  // MARK: Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  /// Подклассы могут переопределять этот метод при надобности.
  func setupViews() {
    let customView = RootView()
    contentView.addSubview(customView)
    customView.fillSuperView()
  }
}

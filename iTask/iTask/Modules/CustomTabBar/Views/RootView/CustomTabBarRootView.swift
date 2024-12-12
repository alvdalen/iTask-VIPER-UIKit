//
//  CustomTabBarRootView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

fileprivate typealias Const = CustomTabBarRootViewConst

// MARK: - Delegate
protocol CustomTabBarRootViewDelegate: AnyObject {
  func didTapAddTaskButton()
}

// MARK: - RootView
final class CustomTabBarRootView: BaseRootView {
  // MARK: Internal Properties
  weak var delegate: CustomTabBarRootViewDelegate?
  
  // MARK: Internal Views
  let taskCountLabel: UILabel = {
    $0.textAlignment = .center
    $0.font = Const.taskCountLabelFont
    return $0
  }(UILabel())
  
  let addTaskButton: UIButton = {
    $0.setImage(Const.taskButtonIcon, for: .normal)
    $0.tintColor = GlobalConst.systemColor
    return $0
  }(UIButton(type: .system))
  
  // MARK: Private Views
  private let blurEffect: UIBlurEffect = {
    return $0
  }(UIBlurEffect(style: .systemChromeMaterial))
  
  private lazy var customTabBarView: UIVisualEffectView = {
    return $0
  }(UIVisualEffectView(effect: blurEffect))
  
  // MARK: Internal Methods
  override func setupViews() {
    addSubviews()
    setConstraints()
    addTaskButtonTarget()
  }
  
  func configTabBar() {
    let tabBarHeight: CGFloat = Const.tabBarHeight
    let safeAreaBottom = safeAreaInsets.bottom
    customTabBarView.frame = CGRect(
      x: .zero,
      y: frame.height - tabBarHeight - safeAreaBottom,
      width: frame.width,
      height: tabBarHeight + safeAreaBottom
    )
  }
  
  func enableAddTaskButton() {
    addTaskButton.isEnabled = true
  }
  
  func disableAddTaskButton() {
    addTaskButton.isEnabled = false
  }
}

// MARK: - Private Methods
private extension CustomTabBarRootView {
  func addSubviews() {
    addSubview(customTabBarView)
    customTabBarView.contentView.addSubview(taskCountLabel)
    customTabBarView.contentView.addSubview(addTaskButton)
  }
  
  func setConstraints() {
    taskCountLabel.setConstraints(
      centerY: customTabBarView.centerYAnchor,
      centerX: customTabBarView.centerXAnchor,
      pCenterY: Const.taskCountLabelOffsetY
    )
    
    addTaskButton.setConstraints(
      trailing: customTabBarView.trailingAnchor,
      centerY: customTabBarView.centerYAnchor,
      pTrailing: Const.addTaskButtonOffsetTrailing,
      pCenterY: Const.addTaskButtonOffsetY
    )
  }
  
  func addTaskButtonTarget() {
    addTaskButton.addTarget(
      self,
      action: #selector(didTapAddTaskButton),
      for: .touchUpInside
    )
  }
  
  @objc func didTapAddTaskButton() {
    delegate?.didTapAddTaskButton()
  }
}

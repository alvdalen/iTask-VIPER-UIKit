//
//  CustomTabBarController.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

fileprivate typealias Const = CustomTabBarControllerConst

// MARK: - Delegate
protocol CustomTabBarControllerDelegate: AnyObject {
  func didTapAddTaskButton()
}

// MARK: - CustomTabBarController
final class CustomTabBarController: UITabBarController {
  // MARK: Internal Properties
  weak var customTabBarDelegate: CustomTabBarControllerDelegate?
  
  // MARK: Internal Views
  let taskCountLabel: UILabel = {
    $0.textAlignment = .center
    $0.font = Const.taskCountLabelFont
    return $0
  }(UILabel())
  
  // MARK: Private Views
  private let blurEffect: UIBlurEffect = {
    return $0
  }(UIBlurEffect(style: .systemChromeMaterial))
  
  private lazy var customTabBarView: UIVisualEffectView = {
    return $0
  }(UIVisualEffectView(effect: blurEffect))
  
  private let addTaskButton: UIButton = {
    $0.setImage(Const.taskButtonIcon, for: .normal)
    $0.tintColor = GlobalConst.systemColor
    return $0
  }(UIButton(type: .system))
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    configTabBar()
  }
  
  // MARK: Internal Methods
  /// Отключить кнопку новой задачи.
  func disableAddTaskButton() {
    addTaskButton.isEnabled = false
  }
  
  /// Включить кнопку новой задачи.
  func enableAddTaskButton() {
    addTaskButton.isEnabled = true
  }
}

// MARK: - Private Methods
private extension CustomTabBarController {
  func initView() {
    setupCustomTabBar()
    addTaskButtonTarget()
  }
  
  func setupCustomTabBar() {
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    view.addSubview(customTabBarView)
    customTabBarView.contentView.addSubview(taskCountLabel)
    customTabBarView.contentView.addSubview(addTaskButton)
  }
  
  func setConstraints() {
    taskCountLabel.centerX()
    taskCountLabel.setConstraints(
      centerY: tabBar.centerYAnchor,
      pCenterY: Const.taskCountLabelOffsetY
    )
    
    addTaskButton.setConstraints(
      centerY: tabBar.centerYAnchor,
      pCenterY: Const.addTaskButtonOffsetY
    )
    addTaskButton.setConstraints(
      trailing: tabBar.trailingAnchor,
      pTrailing: Const.addTaskButtonOffsetTrailing
    )
  }
  
  func configTabBar() {
    tabBar.isHidden = true
    let tabBarHeight: CGFloat = Const.tabBarHeight
    let safeAreaBottom = view.safeAreaInsets.bottom
    customTabBarView.frame = CGRect(
      x: .zero,
      y: view.frame.height - tabBarHeight - safeAreaBottom,
      width: view.frame.width,
      height: tabBarHeight + safeAreaBottom
    )
  }
  
  func addTaskButtonTarget() {
    addTaskButton.addTarget(
      self,
      action: #selector(didTapNewTaskButton),
      for: .touchUpInside
    )
  }
  
  @objc func didTapNewTaskButton() {
    customTabBarDelegate?.didTapAddTaskButton()
  }
}

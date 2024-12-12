//
//  CustomTabBarController.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

typealias BaseCustomTabBarController = BaseTabBarController<CustomTabBarRootView>

// MARK: - Delegate
protocol CustomTabBarControllerDelegate: AnyObject {
  func didTapAddTaskButton()
}

// MARK: - CustomTabBarController
final class CustomTabBarController: BaseCustomTabBarController {
  // MARK: Internal Properties
  weak var customTabBarDelegate: CustomTabBarControllerDelegate?
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegate()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    configTabBar()
  }
  
  // MARK: Internal Methods
  /// Отключить кнопку новой задачи.
  func disableAddTaskButton() {
    rootView.disableAddTaskButton()
  }
  
  /// Включить кнопку новой задачи.
  func enableAddTaskButton() {
    rootView.enableAddTaskButton()
  }
  
  // MARK: Private Methods
  private func setupDelegate() {
    rootView.delegate = self
  }
  
  private func configTabBar() {
    tabBar.isHidden = true
    rootView.configTabBar()
  }
}

// MARK: - CustomTabBarControllerDelegate
extension CustomTabBarController: CustomTabBarRootViewDelegate {
  func didTapAddTaskButton() {
    customTabBarDelegate?.didTapAddTaskButton()
    print(#function)
  }
}

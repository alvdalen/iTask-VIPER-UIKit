//
//  TodoListRouter.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

/// Управление навигацией
final class TodoListRouter: TodoListRouterProtocol {
  
  weak var viewController: UIViewController?
  
  func navigateToTodoDetails(
    with todo: Todo?,
    delegate: TodoDetailsDelegate,
    navTitle: String
  ) {
    let detailsVC = TodoDetailsAssembly.build(
      with: todo,
      delegate: delegate,
      navTitle: navTitle
    )
    viewController?.navigationController?.pushViewController(
      detailsVC,
      animated: true
    )
  }
}

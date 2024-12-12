//
//  TodoListViewController + MainTabBarControllerDelegate.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

extension TodoListViewController: CustomTabBarControllerDelegate {
  func didTapAddTaskButton() {
    presenter.addNewTodo(navTitle: TodoListViewControllerConst.addNavTitleText)
  }
}

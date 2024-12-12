//
//  TodoListViewController + TodoListViewProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

extension TodoListViewController: TodoListViewProtocol {
  func reloadData() {
    rootView.todoListTableView.reloadData()
    guard !searchController.isActive else { return }
    animateTableViewUpdates(with: .middle)
  }
  
  func showError(_ message: String) {
    let alert = UIAlertController(
      title: TodoListViewControllerConst.showErrorTitleText,
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(
      UIAlertAction(
        title: TodoListViewControllerConst.showErrorOkText,
        style: .default
      )
    )
    present(alert, animated: true)
  }
}

//
//  TodoListViewController + TodoListTableViewCellDelegate.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import Foundation

extension TodoListViewController: TodoListTableViewCellDelegate {
  func didTapStateTaskButton(for todo: Todo) {
    guard let index = presenter.indexOf(todo: todo) else { return }
    presenter.toggleTodoCompleted(at: index)
    let indexPath = IndexPath(row: index, section: .zero)
    rootView.todoListTableView.reloadRows(
      at: [indexPath],
      with: .automatic
    )
  }
}

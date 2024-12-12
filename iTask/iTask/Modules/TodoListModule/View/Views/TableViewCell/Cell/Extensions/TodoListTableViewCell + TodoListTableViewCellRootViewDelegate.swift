//
//  TodoListTableViewCell + TodoListTableViewCellRootViewDelegate.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

extension TodoListTableViewCell: TodoListTableViewCellRootViewDelegate {
  func didTapStateTaskButton() {
    if let todo = todo {
      delegate?.didTapStateTaskButton(for: todo)
    }
  }
}

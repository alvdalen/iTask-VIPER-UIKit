//
//  TodoListTableView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

final class TodoListTableView: BaseTableView {
  override func cellRegister() {
    register(
      TodoListTableViewCell.self,
      forCellReuseIdentifier: TodoListTableViewCell.reuseID
    )
  }
}

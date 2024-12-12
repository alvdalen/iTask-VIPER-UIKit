//
//  TodoListViewControllerRootView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

final class TodoListViewControllerRootView: BaseRootView {
  // MARK: Views
  let todoListTableView: TodoListTableView = {
    return $0
  }(TodoListTableView())
  
  // MARK: Setup Views
  override func setupViews() {
    addSubview(todoListTableView)
    todoListTableView.fillSuperView()
  }
}

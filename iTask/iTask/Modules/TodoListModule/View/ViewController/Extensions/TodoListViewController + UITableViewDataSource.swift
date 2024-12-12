//
//  TodoListViewController + UITableViewDataSource.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

// MARK: - UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    switch searchController.isActive {
    case true:
      return presenter.filteredTodosCount
    case false:
      return presenter.todosCount
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    return getCell(tableView, indexPath)
  }
}

// MARK: - Private Methods
private extension TodoListViewController {
  func getCell(
    _ tableView: UITableView,
    _ indexPath: IndexPath
  ) -> TodoListTableViewCell {
    
    let cell = tableView.dequeueReusableCell(
      withIdentifier: TodoListTableViewCell.reuseID,
      for: indexPath
    ) as! TodoListTableViewCell
    
    let todo: Todo
    switch searchController.isActive {
    case true:
      todo = presenter.filteredTodo(at: indexPath.row)
    case false:
      todo = presenter.todo(at: indexPath.row)
    }
    
    configCell(todo, cell)
    return cell
  }
  
  func configCell(_ todo: Todo, _ cell: TodoListTableViewCell) {
    let todoTitle = todo.title
    let todoBody = todo.body
    let todoCompleted = todo.completed
    let attributedTitle = getAttributedTitle(for: todoTitle, completed: todoCompleted)
    cell.delegate = self
    cell.todo = todo
    cell.selectionStyle = .none
    cell.accessoryType = .disclosureIndicator
    cell.rootView.configure(
      attributedTitle,
      todoBody,
      todo.date,
      todo.completed
    )
  }
  
  /// Зачеркнуть текст в зависимости от того есть задача или ее нет.
  func getAttributedTitle(
    for title: String,
    completed: Bool
  ) -> NSAttributedString {
    var attributes: [NSAttributedString.Key: Any] = [:]
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = .byWordWrapping
    if !completed {
      attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
    }
    return NSAttributedString(string: title, attributes: attributes)
  }
}

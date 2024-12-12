//
//  TodoDetailsProtocols.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

// MARK: - View
protocol TodoDetailsViewProtocol: AnyObject {
  func showTodoContent(
    _ taskTitle: String,
    _ taskBody: String,
    _ taskDate: String
  )
}

// MARK: - Presenter
protocol TodoDetailsPresenterProtocol: AnyObject {
  var navTitle: String { get }
  func viewDidLoad()
  func getTodo() -> Todo?
  func deleteTodo(_ todo: Todo)
  func saveTodo(
    _ taskTitle: String,
    _ taskBody: String,
    _ taskDate: String
  )
}

// MARK: - Router
protocol TodoDetailsRouterProtocol: AnyObject {
  func navigateBack()
}

// MARK: - Делегат для обратной передачи данных в ячейку
protocol TodoDetailsDelegate: AnyObject {
  func didSaveTodo(_ todo: Todo)
  func didDeleteTodo(_ todo: Todo)
}

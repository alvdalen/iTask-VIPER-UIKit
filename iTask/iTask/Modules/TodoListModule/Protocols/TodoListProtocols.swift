//
//  TodoListProtocols.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

// MARK: - View
protocol TodoListViewProtocol: AnyObject {
  var presenter: TodoListPresenterProtocol! { get set }
  func reloadData()
  func showError(_ message: String)
}

// MARK: - Presenter
protocol TodoListPresenterProtocol: AnyObject {
  var todos: Todos { get }
  var filteredTodos: Todos { get }
  var todosCount: Int { get }
  var filteredTodosCount: Int { get }
  func viewDidLoad()
  func todo(at index: Int) -> Todo
  func filteredTodo(at index: Int) -> Todo
  func didSelectTodo(at index: Int, navTitle: String)
  func deleteTodo(at index: Int)
  func addNewTodo(navTitle: String)
  func didFailWithError(_ error: Error)
  func reloadData()
  func toggleTodoCompleted(at index: Int)
  func indexOf(todo: Todo) -> Int?
  func filteredItems(searchText: String?)
}

// MARK: - Interactor
protocol TodoListInteractorProtocol: AnyObject {
  var filteredTodoItems: Todos { get set }
  var todos: Todos { get set }
  var presenter: TodoListPresenterProtocol? { get set }
  func fetchTodos()
  func add(todo: Todo)
  func deleteTodo(at index: Int)
  func update(todo: Todo)
}

// MARK: - Router
protocol TodoListRouterProtocol: AnyObject {
  var viewController: UIViewController? { get set }
  func navigateToTodoDetails(
    with todo: Todo?,
    delegate: TodoDetailsDelegate,
    navTitle: String
  )
}

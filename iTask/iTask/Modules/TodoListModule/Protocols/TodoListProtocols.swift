//
//  TodoListProtocols.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

// MARK: - View
/// Протокол для представления списка задач.
protocol TodoListViewProtocol: AnyObject {
  /// Презентер, связанный с этим представлением.
  var presenter: TodoListPresenterProtocol! { get set }
  
  /// Обновляет данные в пользовательском интерфейсе.
  func reloadData()
  
  /// Показывает сообщение об ошибке.
  /// - Parameter message: Текст ошибки, который будет отображен.
  func showError(_ message: String)
}

// MARK: - Presenter
/// Протокол для управления логикой представления (Presenter).
protocol TodoListPresenterProtocol: AnyObject {
  /// Список всех задач.
  var todos: Todos { get }
  
  /// Отфильтрованный список задач.
  var filteredTodos: Todos { get }
  
  /// Общее количество задач.
  var todosCount: Int { get }
  
  /// Количество отфильтрованных задач.
  var filteredTodosCount: Int { get }
  
  /// Вызывается, когда представление было загружено.
  func viewDidLoad()
  
  /// Возвращает задачу по индексу.
  /// - Parameter index: Индекс задачи в массиве.
  /// - Returns: Задача по указанному индексу.
  func todo(at index: Int) -> Todo
  
  /// Возвращает отфильтрованную задачу по индексу.
  /// - Parameter index: Индекс задачи в отфильтрованном массиве.
  /// - Returns: Отфильтрованная задача по указанному индексу.
  func filteredTodo(at index: Int) -> Todo
  
  /// Обрабатывает выбор задачи.
  /// - Parameters:
  ///   - index: Индекс выбранной задачи.
  ///   - navTitle: Заголовок для перехода.
  func didSelectTodo(at index: Int, navTitle: String)
  
  /// Удаляет задачу по указанному индексу.
  /// - Parameter index: Индекс задачи для удаления.
  func deleteTodo(at index: Int)
  
  /// Добавляет новую задачу.
  /// - Parameter navTitle: Заголовок для перехода.
  func addNewTodo(navTitle: String)
  
  /// Обрабатывает ошибку.
  /// - Parameter error: Объект ошибки.
  func didFailWithError(_ error: Error)
  
  /// Обновляет данные в представлении.
  func reloadData()
  
  /// Переключает статус завершения задачи.
  /// - Parameter index: Индекс задачи для изменения.
  func toggleTodoCompleted(at index: Int)
  
  /// Находит индекс указанной задачи.
  /// - Parameter todo: Задача для поиска.
  /// - Returns: Индекс задачи, если найден, иначе `nil`.
  func indexOf(todo: Todo) -> Int?
  
  /// Фильтрует элементы на основе текста поиска.
  /// - Parameter searchText: Текст для фильтрации, может быть `nil`.
  func filteredItems(searchText: String?)
}

// MARK: - Interactor
/// Протокол для управления данными (Interactor).
protocol TodoListInteractorProtocol: AnyObject {
  /// Отфильтрованные задачи.
  var filteredTodoItems: Todos { get set }
  
  /// Все задачи.
  var todos: Todos { get set }
  
  /// Презентер, связанный с этим интерактором.
  var presenter: TodoListPresenterProtocol? { get set }
  
  /// Загружает список задач.
  func fetchTodos()
  
  /// Добавляет новую задачу.
  /// - Parameter todo: Задача для добавления.
  func add(todo: Todo)
  
  /// Удаляет задачу по индексу.
  /// - Parameter index: Индекс задачи для удаления.
  func deleteTodo(at index: Int)
  
  /// Обновляет указанную задачу.
  /// - Parameter todo: Обновленная задача.
  func update(todo: Todo)
}

// MARK: - Router
/// Протокол для навигации (Router).
protocol TodoListRouterProtocol: AnyObject {
  /// Ссылка на представление.
  var viewController: UIViewController? { get set }
  
  /// Навигация к деталям задачи.
  /// - Parameters:
  ///   - todo: Задача для отображения или `nil` для создания новой.
  ///   - delegate: Делегат для обработки изменений задачи.
  ///   - navTitle: Заголовок для перехода.
  func navigateToTodoDetails(
    with todo: Todo?,
    delegate: TodoDetailsDelegate,
    navTitle: String
  )
}

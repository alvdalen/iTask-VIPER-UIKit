//
//  TodoListPresenter + TodoListPresenterProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

extension TodoListPresenter: TodoListPresenterProtocol {
  // MARK: Properties
  var todosCount: Int {
    return interactor.todos.count
  }
  var filteredTodosCount: Int {
    return interactor.filteredTodoItems.count
  }
  
  var filteredTodos: Todos {
    return interactor.filteredTodoItems
  }
  
  var todos: Todos {
    return interactor.todos
  }
  
  // MARK: Methods
  func filteredItems(searchText: String?) {
    if let searchText = searchText, !searchText.isEmpty {
      interactor.filteredTodoItems = interactor.todos.filter {
        $0.title.lowercased().contains(searchText.lowercased())
      }
    } else {
      interactor.filteredTodoItems = interactor.todos
      view?.reloadData()
    }
    view?.reloadData()
  }
  
  func toggleTodoCompleted(at index: Int) {
    var todo = todos[index]
    todo.completed.toggle()
    interactor.update(todo: todo)
  }
  
  func reloadData() {
    interactor.todos.sort { $0.date > $1.date }
    view?.reloadData()
  }
  
  func viewDidLoad() {
    interactor.fetchTodos()
  }
  
  func todo(at index: Int) -> Todo {
    return todos[index]
  }
  
  func filteredTodo(at index: Int) -> Todo {
    return interactor.filteredTodoItems[index]
  }
  
  func didSelectTodo(at index: Int, navTitle: String) {
    let todo = todos[index]
    router.navigateToTodoDetails(with: todo, delegate: self, navTitle: navTitle)
  }
  
  func deleteTodo(at index: Int) {
    interactor.deleteTodo(at: index)
  }
  
  func addNewTodo(navTitle: String) {
    router.navigateToTodoDetails(with: nil, delegate: self, navTitle: navTitle)
  }
  
  func didFailWithError(_ error: Error) {
    view?.showError(error.localizedDescription)
  }
  
  func indexOf(todo: Todo) -> Int? {
    return todos.firstIndex { $0.id == todo.id }
  }
}

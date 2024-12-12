//
//  TodoListInteractor.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import CoreData

final class TodoListInteractor: NSObject, TodoListInteractorProtocol {
  // MARK: Internal Properties
  let networkService: NetworkServiceProtocol
  let requestService: NetworkRequestServiceProtocol
  var todos: Todos = []
  var filteredTodoItems: Todos = []
  weak var presenter: TodoListPresenterProtocol?
    
  // MARK: Private Properties
  private let coreDataManager: CoreDataManagerProtocol = CoreDataManager(
    modelName: Const.modelName
  )
  
  private lazy var fetchedResultsController: NSFetchedResultsController<TodoEntity> = {
    let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(key: Const.dateKey, ascending: false)
    ]
    let controller = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: coreDataManager.context,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    controller.delegate = self
    return controller
  }()
  
  // MARK: Initializers
  init(
    _ networkService: NetworkServiceProtocol,
    _ requestService: NetworkRequestServiceProtocol
  ) {
    self.networkService = networkService
    self.requestService = requestService
  }
  
  // MARK: Internal Methods
  func fetchTodos() {
    guard savedTodos().isEmpty else {
      fetchTodosFromCoreData()
      return
    }
    fetchTodosFromNetwork()
  }
  
  func add(todo: Todo) {
    do {
      try coreDataManager.addObject(
        ofType: TodoEntity.self
      ) { [weak self] todoEntity in
        var newTodo = todo
        newTodo.date = Date().description // Устанавливаем текущую дату для сортировки
        self?.updateTodoEntity(todoEntity, with: newTodo)
      }
    } catch {
      handleError(error: error)
    }
  }
  
  func deleteTodo(at index: Int) {
    let todo = todos[index]
    do {
      try coreDataManager.deleteObject(
        ofType: TodoEntity.self,
        predicate: predicateForTodoWithId(todo)
      )
    } catch {
      handleError(error: error)
    }
  }
  
  func update(todo: Todo) {
    do {
      try coreDataManager.updateObject(
        ofType: TodoEntity.self,
        predicate: predicateForTodoWithId(todo)
      ) { todoEntity in
        updateTodoEntity(todoEntity, with: todo)
      }
    } catch {
      handleError(error: error)
    }
  }
}

// MARK: - Private Methods
private extension TodoListInteractor {
  func predicateForTodoWithId(_ todo: Todo) -> NSPredicate {
    NSPredicate(format: Const.todoId, todo.id)
  }
  
  func fetchTodosFromCoreData() {
    do {
      try fetchedResultsController.performFetch()
      todos = fetchedResultsController.fetchedObjects?
        .map { convertToTodo(from: $0) } ?? []
      presenter?.reloadData()
    } catch {
      handleError(error: error)
    }
  }
  
  func updateTodoEntity(_ todoEntity: TodoEntity, with todo: Todo) {
    todoEntity.id = todo.id
    todoEntity.title = todo.title
    todoEntity.body = todo.body
    todoEntity.date = todo.date
    todoEntity.completed = todo.completed
  }
  
  /// Метод для преобразования `TodoEntity` в `Todo`.
  func convertToTodo(from entity: TodoEntity) -> Todo {
    return Todo(
      id: entity.id ?? UUID().uuidString,
      title: entity.title ?? .empty,
      body: entity.body ?? .empty,
      date: entity.date ?? .empty,
      completed: entity.completed
    )
  }
  
  /// Метод для получение сохраненных `Todo` из Core Data.
  func savedTodos() -> Entities {
    do {
      return try coreDataManager.fetchObjects(ofType: TodoEntity.self)
    } catch {
      handleError(error: error)
      return []
    }
  }
  
  func handleFetchedTodos(_ fetchedTodos: Todos) {
    coreDataManager.context.perform {
      for todo in fetchedTodos {
        do {
          try self.coreDataManager.addObject(
            ofType: TodoEntity.self
          ) { todoEntity in
            self.updateTodoEntity(todoEntity, with: todo)
          }
        } catch {
          self.handleError(error: error)
        }
      }
      self.fetchTodosFromCoreData()
    }
  }
  
  func handleError(error: Error) {
    self.presenter?.didFailWithError(error)
    self.fetchTodosFromCoreData()
  }
  
  func handleNetworkResponse(_ result: Result<Todos, Error>) {
    switch result {
    case .success(let fetchedTodos):
      handleFetchedTodos(fetchedTodos)
    case .failure(let error):
      handleError(error: error)
    }
  }
  
  func fetchTodosFromNetwork() {
    do {
      let request = try requestService.prepareRequest()
      networkService.request(
        request: request,
        type: Todos.self
      ) { [weak self] result in
        guard let self = self else { return }
        self.handleNetworkResponse(result)
      }
    } catch {
      self.handleError(error: error)
    }
  }
}

// MARK: -  NSFetchedResultsControllerDelegate
extension TodoListInteractor: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(
    _ controller: NSFetchedResultsController<NSFetchRequestResult>
  ) {
    guard let fetchedObjects = fetchedResultsController.fetchedObjects else {
      return
    }
    todos = fetchedObjects.map { todoEntity in
      convertToTodo(from: todoEntity)
    }
  }
}

// MARK: - Constants
private enum Const {
  static let modelName: String = "iTask"
  static let todoId: String = "id == %@"
  static let dateKey = "date"
}

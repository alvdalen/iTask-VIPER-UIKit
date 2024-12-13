//
//  TodoListInteractor.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import CoreData

final class TodoListInteractor: NSObject {
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
}

// MARK: - Private Methods
private extension TodoListInteractor {
  /// Создает предикат для поиска задачи по идентификатору.
  /// - Parameter todo: Задача, для которой нужно создать предикат.
  /// - Returns: `NSPredicate`, использующий идентификатор задачи для фильтрации.
  func predicateForTodoWithId(_ todo: Todo) -> NSPredicate {
    NSPredicate(format: Const.todoId, todo.id)
  }
  
  /// Загружает задачи из Core Data с использованием `fetchedResultsController`.
  /// В случае успеха обновляет список задач и уведомляет презентер о необходимости перезагрузки данных.
  /// В случае ошибки вызывает обработчик ошибок.
  func fetchTodosFromCoreData() {
    do {
      try fetchedResultsController.performFetch()
      
      /// Преобразоваь извлеченные объекты `TodoEntity` в `Todo` и обновить список задач.
      todos = fetchedResultsController.fetchedObjects?.map { todoEntity in
        convertToTodo(from: todoEntity)
      } ?? []
      presenter?.reloadData()
    } catch {
      handleError(error: error)
    }
  }
  
  /// Метод для обновления данных `TodoEntity` из `Todo`.
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
  
  /// Получает сохраненные задачи из Core Data.
  /// - Returns: Массив объектов `TodoEntity`, представляющих сохраненные задачи.
  func savedTodos() -> Entities {
    do {
      return try coreDataManager.fetchObjects(ofType: TodoEntity.self)
    } catch {
      handleError(error: error)
      return []
    }
  }
  
  /// Обрабатывает полученные задачи, добавляя их в Core Data.
  /// - Parameter fetchedTodos: Список задач, полученных из сети.
  func handleFetchedTodos(_ fetchedTodos: Todos) {
    // Асинхронная операция с контекстом Core Data
    coreDataManager.context.perform { [weak self] in
      guard let self = self else { return }
      for todo in fetchedTodos {
        do {
          // Добавить каждую задачу в Core Data.
          try self.coreDataManager.addObject(
            ofType: TodoEntity.self
          ) { todoEntity in
            // Обновить сущность в Core Data данными из задачи.
            self.updateTodoEntity(todoEntity, with: todo)
          }
        } catch {
          self.handleError(error: error)
        }
      }
      // После добавления задач, выполнить загрузку задач из Core Data.
      self.fetchTodosFromCoreData()
    }
  }
  
  /// Обрабатывает ошибку, передавая её презентеру и выполняя повторный запрос данных из Core Data.
  /// - Parameter error: Ошибка.
  func handleError(error: Error) {
    self.presenter?.didFailWithError(error)
    self.fetchTodosFromCoreData()
  }
  
  /// Обрабатывает ответ от сети, в зависимости от успешности запроса.
  /// - Parameter result: Результат выполнения сетевого запроса, содержащий либо задачи, либо ошибку.
  func handleNetworkResponse(_ result: Result<Todos, Error>) {
    switch result {
    case .success(let fetchedTodos):
      handleFetchedTodos(fetchedTodos)
    case .failure(let error):
      handleError(error: error)
    }
  }
  
  /// Загружает задачи из сети, выполняя запрос и обрабатывая ответ.
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

// MARK: - TodoListInteractorProtocol
extension TodoListInteractor: TodoListInteractorProtocol {
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
        newTodo.date = Date().description // Устанавить текущую дату для сортировки.
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
  /// Имя модели для Core Data.
  static let modelName: String = "iTask"
  
  /// Формат предиката для поиска задачи по идентификатору.
  static let todoId: String = "id == %@"
  
  /// Ключ для сортировки задач по дате.
  static let dateKey = "date"
}

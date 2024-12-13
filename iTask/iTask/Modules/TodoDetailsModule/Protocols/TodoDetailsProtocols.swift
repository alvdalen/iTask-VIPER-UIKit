//
//  TodoDetailsProtocols.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

// MARK: - View
/// Протокол для представления деталей задачи (View).
protocol TodoDetailsViewProtocol: AnyObject {
  /// Отображает содержимое задачи.
  /// - Parameters:
  ///   - taskTitle: Название задачи.
  ///   - taskBody: Описание задачи.
  ///   - taskDate: Дата задачи.
  func showTodoContent(
    _ taskTitle: String,
    _ taskBody: String,
    _ taskDate: String
  )
}

// MARK: - Presenter
/// Протокол для управления логикой представления деталей задачи (Presenter).
protocol TodoDetailsPresenterProtocol: AnyObject {
  /// Заголовок для навигации.
  var navTitle: String { get }
  
  /// Вызывается при загрузке представления.
  func viewDidLoad()
  
  /// Возвращает текущую задачу.
  /// - Returns: Объект задачи или `nil`, если задача отсутствует.
  func getTodo() -> Todo?
  
  /// Удаляет задачу.
  /// - Parameter todo: Задача, которую нужно удалить.
  func deleteTodo(_ todo: Todo)
  
  /// Сохраняет изменения в задаче.
  /// - Parameters:
  ///   - taskTitle: Новое название задачи.
  ///   - taskBody: Новое описание задачи.
  ///   - taskDate: Новая дата задачи.
  func saveTodo(
    _ taskTitle: String,
    _ taskBody: String,
    _ taskDate: String
  )
}

// MARK: - Router
/// Протокол для навигации из деталей задачи (Router).
protocol TodoDetailsRouterProtocol: AnyObject {
  /// Выполняет переход назад по навигационному стеку.
  func navigateBack()
}

// MARK: - Делегат для обратной передачи данных в ячейку
/// Протокол делегата для обратной связи с представлением списка задач.
protocol TodoDetailsDelegate: AnyObject {
  /// Вызывается при сохранении задачи.
  /// - Parameter todo: Сохраненная задача.
  func didSaveTodo(_ todo: Todo)
  
  /// Вызывается при удалении задачи.
  /// - Parameter todo: Удаленная задача.
  func didDeleteTodo(_ todo: Todo)
}

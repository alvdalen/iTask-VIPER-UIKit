//
//  TodoDetailsPresenter + TodoDetailsPresenterProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import Foundation

extension TodoDetailsPresenter: TodoDetailsPresenterProtocol {
  func saveTodo(_ taskTitle: String, _ taskBody: String, _ taskDate: String) {
    let dateFormatter = DateFormatter()
    let updatedTodo =  Todo(
      id: todo?.id ?? UUID().uuidString,
      title: taskTitle,
      body: taskBody,
      date: todo?.date ?? dateFormatter.string(from: Date()),
      completed: todo?.completed ?? true // новый туду всегда актуален
    )
    delegate?.didSaveTodo(updatedTodo)
    router.navigateBack()
  }
  
  func viewDidLoad() {
    if let todo = todo {
      view?.showTodoContent(todo.title, todo.body, todo.date)
    }
  }
  
  func getTodo() -> Todo? {
    return todo
  }
  
  func deleteTodo(_ todo: Todo) {
    // Уведомляем делегата об удалении задачи
    delegate?.didDeleteTodo(todo)
    // Навигация обратно на предыдущий экран
    router.navigateBack()
  }
}

//
//  TodoListPresenter + TodoDetailsDelegate.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

extension TodoListPresenter: TodoDetailsDelegate {
  func didSaveTodo(_ todo: Todo) {
    if interactor.todos.contains(where: { $0.id == todo.id }) {
      // Обновляем существующую заметку
      interactor.update(todo: todo)
    } else {
      // Добавляем новую заметку в начало списка
      interactor.add(todo: todo)
    }
    view?.reloadData()
  }
  
  func didDeleteTodo(_ todo: Todo) {
    // Удаляем задачу из списка, если она есть
    if let index = interactor.todos.firstIndex(where: { $0.id == todo.id }) {
      interactor.deleteTodo(at: index)
      view?.reloadData()
    }
  }
}
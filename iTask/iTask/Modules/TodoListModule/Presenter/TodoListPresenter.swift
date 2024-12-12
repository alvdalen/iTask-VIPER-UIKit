//
//  TodoListPresenter.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

final class TodoListPresenter {
  // MARK: Internal Properties
  let interactor: TodoListInteractorProtocol
  let router: TodoListRouterProtocol
  
  // MARK: Private Properties
  private(set) weak var view: TodoListViewProtocol?
  
  // MARK: Initializers
  init(
    view: TodoListViewProtocol,
    interactor: TodoListInteractorProtocol,
    router: TodoListRouterProtocol
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

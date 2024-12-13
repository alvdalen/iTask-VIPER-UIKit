//
//  TodoDetailsPresenter.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import Foundation

final class TodoDetailsPresenter {
  // MARK: Internal Properties
  let todo: Todo?
  let router: TodoDetailsRouterProtocol
  var navTitle: String
  
  // MARK: Private Properties
  private(set) weak var view: TodoDetailsViewProtocol?
  private(set) weak var delegate: TodoDetailsDelegate?
  
  // MARK: Initializers
  init(
    view: TodoDetailsViewProtocol,
    router: TodoDetailsRouterProtocol,
    delegate: TodoDetailsDelegate,
    todo: Todo?,
    navTitle: String
  ) {
    self.view = view
    self.router = router
    self.delegate = delegate
    self.todo = todo
    self.navTitle = navTitle
  }
}

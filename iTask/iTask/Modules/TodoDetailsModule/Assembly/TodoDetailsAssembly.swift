//
//  TodoDetailsAssembly.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

final class TodoDetailsAssembly {
  static func build(
    with todo: Todo?,
    delegate: TodoDetailsDelegate,
    navTitle: String
  ) -> UIViewController {
    let view = TodoDetailViewController()
    let router = TodoDetailsRouter()
    let presenter = TodoDetailsPresenter(
      view: view,
      router: router,
      delegate: delegate,
      todo: todo,
      navTitle: navTitle
    )
    view.presenter = presenter
    router.viewController = view
    return view
  }
}

//
//  TodoDetailsAssembly.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

final class TodoDetailsAssembly {
  /// Метод для создания и настройки экрана деталей задачи.
  /// - Parameters:
  ///   - todo: Объект задачи, для которой создаются детали.
  ///   - delegate: Делегат для обратной связи.
  ///   - navTitle: Заголовок для навигационной панели.
  /// - Returns: Готовый для использования `UIViewController` экрана деталей задачи.
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

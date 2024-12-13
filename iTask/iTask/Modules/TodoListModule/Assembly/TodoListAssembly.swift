//
//  TodoListAssembly.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

final class TodoListAssembly {
  /// Метод для создания и настройки всех необходимых компонентов и их связей.
  /// - Returns: Настроенный `UINavigationController`,
  /// содержащий `TodoListViewController`.
  static func build() -> UINavigationController {
    // сервисы
    let networkService: NetworkServiceProtocol = NetworkService()
    let requestService: NetworkRequestServiceProtocol = NetworkRequestService()
    
    // компоненты
    let view = TodoListViewController()
    let router: TodoListRouterProtocol = TodoListRouter()
    let interactor: TodoListInteractorProtocol = TodoListInteractor(
      networkService,
      requestService
    )
    let presenter: TodoListPresenterProtocol = TodoListPresenter(
      view: view,
      interactor: interactor,
      router: router
    )
    
    // связать компоненты
    interactor.presenter = presenter
    view.presenter = presenter
    router.viewController = view
    
    let navigationController = UINavigationController(rootViewController: view)
    return navigationController
  }
}

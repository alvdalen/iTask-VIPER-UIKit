//
//  SceneDelegate.swift
//  iTask
//
//  Created by Адам Мирзаканов on 11.12.2024.
//

import UIKit

final class SceneDelegate: UIResponder {
  var window: UIWindow?
}

// MARK: - UIWindowSceneDelegate
extension SceneDelegate: UIWindowSceneDelegate {
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    configWindow(with: scene)
  }
}

// MARK: - Config Window
private extension SceneDelegate {
  func configWindow(with scene: UIScene) {
    guard let windowScene = scene as? UIWindowScene else { return }
    let viewController = TodoListAssembly.build()
    let tabBarController = CustomTabBarController()
    tabBarController.viewControllers = [viewController]
    window = UIWindow(windowScene: windowScene)
    window?.windowScene = windowScene
    window?.rootViewController = tabBarController
    window?.overrideUserInterfaceStyle = .dark
    window?.makeKeyAndVisible()
  }
}

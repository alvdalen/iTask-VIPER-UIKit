//
//  BaseTabBarController.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

class BaseTabBarController<ViewType: UIView>: UITabBarController {
  
  typealias RootView = ViewType
  
  override func loadView() {
    let customView = RootView()
    view = customView
  }
}

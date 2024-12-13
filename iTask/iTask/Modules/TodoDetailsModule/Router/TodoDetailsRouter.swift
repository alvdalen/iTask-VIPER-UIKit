//
//  TodoDetailsRouter.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

final class TodoDetailsRouter: TodoDetailsRouterProtocol {
  
  weak var viewController: UIViewController?
  
  func navigateBack() {
    viewController?.navigationController?.popViewController(animated: true)
  }
}

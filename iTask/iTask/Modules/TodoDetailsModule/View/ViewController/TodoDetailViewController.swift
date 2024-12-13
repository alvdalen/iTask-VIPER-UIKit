//
//  TodoDetailViewController.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

typealias BaseTodoDetailViewController = BaseViewController<TodoDetailViewControllerRootView>

// MARK: - ViewController
final class TodoDetailViewController: BaseTodoDetailViewController {
  // MARK: Internal Properties
  var presenter: TodoDetailsPresenterProtocol!
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    stateButtons()
  }
}

// MARK: - Private Methods
private extension TodoDetailViewController {
  func initView() {
    disableAddTaskButton()
    configNavigationBar()
    setupButtons()
    presenter?.viewDidLoad()
  }
  
  /// Отключить кнопку добавления новой задачи.
  func disableAddTaskButton() {
    if let tabBarController = tabBarController as? CustomTabBarController {
      tabBarController.disableAddTaskButton()
    }
  }
  
  func configNavigationBar() {
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = GlobalConst.systemColor
    navigationItem.title = presenter.navTitle
  }
  
  func setupButtons() {
    setupDeleteBarButton()
    setupSaveButton()
  }
  
  func setupSaveButton() {
    rootView.saveButton.addTarget(
      self,
      action: #selector(saveButtonTapped),
      for: .touchUpInside
    )
  }
  
  func setupDeleteBarButton() {
    rootView.deleteButton.addTarget(
      self,
      action: #selector(deleteButtonTapped),
      for: .touchUpInside
    )
    let deleteBarButtonItem = UIBarButtonItem(customView: rootView.deleteButton)
    navigationItem.rightBarButtonItems = [deleteBarButtonItem]
  }
  
  @objc func deleteButtonTapped() {
    // Получение текущей задачи через presenter
    guard let todo = presenter.getTodo() else {
      return
    }
    presenter.deleteTodo(todo)
    navigationController?.popViewController(animated: true)
  }
  
  @objc func saveButtonTapped() {
    let taskTitle = rootView.taskTitleTextView.text ?? .empty
    let taskBody = rootView.taskBodyTextView.text ?? .empty
    let taskDate = rootView.dateLabel.text ?? .empty
    presenter.saveTodo(taskTitle, taskBody, taskDate)
    navigationController?.popViewController(animated: true)
  }
  
  func deleteButtonState() {
    guard presenter.getTodo() != nil else {
      rootView.deleteButton.isEnabled = false
      return
    }
  }
  
  func stateButtons() {
    deleteButtonState()
    rootView.stateSaveButton()
  }
}

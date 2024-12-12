//
//  TodoListViewController.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

fileprivate typealias Const = TodoListViewControllerConst
typealias BaseTodoListViewController = BaseViewController<TodoListViewControllerRootView>

// MARK: - ViewController
final class TodoListViewController: BaseTodoListViewController {
  // MARK: Internal Properties
  var presenter: TodoListPresenterProtocol!
  
  let searchController: UISearchController = {
    $0.obscuresBackgroundDuringPresentation = true
    $0.searchBar.autocapitalizationType = .sentences
    return $0
  }(UISearchController())
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    enableAddTaskButton()
  }
  
  // MARK: Internal Methods
  func animateTableViewUpdates(with animation: UITableView.RowAnimation) {
    guard rootView.todoListTableView.window != nil else { return }
    let indexSet = IndexSet(integer: .zero)
    self.rootView.todoListTableView.reloadSections(indexSet, with: animation)
  }
}

// MARK: - Private Methods
private extension TodoListViewController {
  private func initView() {
    setupTableViewDelegates()
    setupSearchContrllerDelegate()
    configNavigationBar()
    presenter.viewDidLoad()
  }
  
  func setupTableViewDelegates() {
    rootView.todoListTableView.delegate = self
    rootView.todoListTableView.dataSource = self
  }
  
  func setupSearchContrllerDelegate() {
    searchController.searchResultsUpdater = self
  }
  
  func configNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.title = Const.navigationItemTitleText
    navigationItem.searchController = searchController
    searchController.searchBar.tintColor = GlobalConst.systemColor
  }
  
  /// Включить кнопку добавления новой задачи.
  func enableAddTaskButton() {
    guard let tabBar = self.tabBarController as? CustomTabBarController else { return }
    tabBar.enableAddTaskButton()
  }
}

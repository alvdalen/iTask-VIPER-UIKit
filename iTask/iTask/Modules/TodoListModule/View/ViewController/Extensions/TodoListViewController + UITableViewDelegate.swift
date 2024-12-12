//
//  TodoListViewController + UITableViewDelegate.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

fileprivate typealias Const = TodoListViewControllerConst

// MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    contextMenuConfigurationForRowAt indexPath: IndexPath,
    point: CGPoint
  ) -> UIContextMenuConfiguration? {
    let todo = presenter.todo(at: indexPath.row)
    return createContextMenuConfiguration(tableView, for: indexPath, with: todo)
  }
  
  /// Отобразить разделительные линии таблицы после исчезновения контекстного меню.
  func tableView(
    _ tableView: UITableView,
    willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
    // Получите индекс ячейки из идентификатора
    guard
      let indexPath = configuration.identifier as? IndexPath,
      let cell = tableView.cellForRow(at: indexPath) as? TodoListTableViewCell
    else {
      return
    }
    tableView.separatorStyle = .singleLine
    animator?.addAnimations {
      cell.restoreContentPosition()
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    presenter.didSelectTodo(at: indexPath.row, navTitle: Const.editNavTitleText)
  }
  
  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      deleteItem(tableView, at: indexPath)
    }
  }
  
  /// Footer таблицы
  func tableView(
    _ tableView: UITableView,
    viewForFooterInSection section: Int
  ) -> UIView? {
    guard section == .zero else { return nil }
    let footerView = UIView()
    return footerView
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForFooterInSection section: Int
  ) -> CGFloat {
    guard section == .zero else { return .zero }
    return getTabBarHeight()
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    
    return Const.rowHeight
  }
}

// MARK: - Private Methods
private extension TodoListViewController {
  /// Конфигурация контекстного меню.
  func createContextMenuConfiguration(
    _ tableView: UITableView,
    for indexPath: IndexPath,
    with item: Todo
  ) -> UIContextMenuConfiguration {
    
    return UIContextMenuConfiguration(
      identifier: indexPath as NSIndexPath,
      previewProvider: nil
    ) { _ in
      self.createContextMenuActions(tableView, for: indexPath, with: item)
    }
  }
  
  /// Контекстное меню.
  func createContextMenuActions(
    _ tableView: UITableView,
    for indexPath: IndexPath,
    with item: Todo
  ) -> UIMenu {
    let editAction = createEditAction(tableView, for: indexPath)
    let shareAction = createShareAction(for: item.body)
    let deleteAction = createDeleteAction(tableView, for: indexPath)
    
    /// Скрыть разделительные линии таблицы когда отображается контекстное меню.
    /// Если не скрыть, будут отображаться линии сверху и снизу на выделяющейся ячейке.
    /// Эти линии не очень заметны, но они портят внешний вид ячейки в этом состоянии.
    tableView.separatorStyle = .none
    
    /// Анимировать содержимое ячейки что бы оно сдвигалось влево скрывая кнопку.
    let cell = tableView.cellForRow(at: indexPath) as! TodoListTableViewCell
    cell.moveContentLeft()
    
    return UIMenu(
      title: .empty,
      children: [editAction, shareAction, deleteAction]
    )
  }
  
  /// Экшн "Редактировать".
  func createEditAction(
    _ tableView: UITableView,
    for indexPath: IndexPath
  ) -> UIAction {
    return UIAction(
      title: Const.contextMenuEditTitleText,
      image: Const.editIcon
    ) { _ in
      self.editItem(tableView, at: indexPath)
    }
  }
  
  /// Экшн "Поделиться".
  func createShareAction(for todo: String) -> UIAction {
    return UIAction(
      title: Const.contextMenuShareTitleText,
      image: Const.shareIcon
    ) { _ in
      self.shareItem(todo)
    }
  }
  
  /// Экшн "Удалить".
  func createDeleteAction(
    _ tableView: UITableView,
    for indexPath: IndexPath
  ) -> UIAction {
    return UIAction(
      title: Const.contextMenuDeleteTitleText,
      image: Const.deleteIcon,
      attributes: .destructive
    ) { _ in
      self.deleteItem(tableView, at: indexPath)
    }
  }
  
  // открыть экран для редактирования
  func editItem(_ tableView: UITableView, at indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.didSelectTodo(at: indexPath.row, navTitle: Const.editNavTitleText)
  }
  
  // поделится
  func shareItem(_ item: String) {
    let activityVC = UIActivityViewController(
      activityItems: [item],
      applicationActivities: nil
    )
    present(activityVC, animated: true, completion: nil)
  }
  
  // удалить
  func deleteItem(
    _ tableView: UITableView,
    at indexPath: IndexPath
  ) {
    let cell = tableView.cellForRow(at: indexPath) as! TodoListTableViewCell
    tableView.performBatchUpdates {
      presenter.deleteTodo(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      cell.restoreContentPosition()
    }
  }
  
  /// Получить высоту Таббара для футтера таблицы.
  ///
  /// Так как панель вкладок теперь костомная она не скрывается в конце скрола,
  /// изза чего последняя ячейка перекрывается, для предотвращения такого
  /// поведения я использую футтер.
  func getTabBarHeight() -> CGFloat {
    guard
      let tabBarController = self.tabBarController as? CustomTabBarController
    else {
      return .zero
    }
    updateTodosCountText(tabBarController: tabBarController)
    return tabBarController.tabBar.frame.height
  }
  
  func updateTodosCountText(tabBarController: CustomTabBarController) {
    tabBarController.tabBar.tintColor = .white
    let todosCountString = String(presenter.todosCount)
    let todosCountTitle = todosCountString + Const.tabBarTaskCountTitleText
    tabBarController.rootView.taskCountLabel.text = todosCountTitle
    tabBarController.customTabBarDelegate = self
  }
}

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
  /// Конфигурирует контекстное меню для строки таблицы.
  func tableView(
    _ tableView: UITableView,
    contextMenuConfigurationForRowAt indexPath: IndexPath,
    point: CGPoint
  ) -> UIContextMenuConfiguration? {
    let todo = presenter.todo(at: indexPath.row)
    return createContextMenuConfiguration(tableView, for: indexPath, with: todo)
  }
  
  /// Обрабатывает завершение взаимодействия с контекстным меню для строки таблицы.
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
    // Отобразить разделительные линии таблицы после исчезновения контекстного меню.
    tableView.separatorStyle = .singleLine
    animator?.addAnimations {
      cell.restoreContentPosition()
    }
  }
  
  /// Обрабатывает выбор строки в таблице.
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    presenter.didSelectTodo(at: indexPath.row, navTitle: Const.editNavTitleText)
  }
  
  /// Обрабатывает действия редактирования ячейки таблицы (удаление).
  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      deleteItem(tableView, at: indexPath)
    }
  }
  
  /// Возвращает высоту строки таблицы для заданного индекса.
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return Const.rowHeight
  }
  
  /// Получение Футера для таблицы.
  func tableView(
    _ tableView: UITableView,
    viewForFooterInSection section: Int
  ) -> UIView? {
    guard section == .zero else { return nil }
    let footerView = UIView()
    return footerView
  }
  
  /// Возвращает высоту футера для раздела таблицы.
  func tableView(
    _ tableView: UITableView,
    heightForFooterInSection section: Int
  ) -> CGFloat {
    guard section == .zero else { return .zero }
    return getTabBarHeight()
  }
}

// MARK: - Private Methods
private extension TodoListViewController {
  /// Создает конфигурацию для контекстного меню строки таблицы.
  /// - Parameters:
  ///   - tableView: Таблица, для которой создается контекстное меню.
  ///   - indexPath: Для которой создается меню.
  ///   - item: Элемент таблицы, с которым будет связано контекстное меню.
  /// - Returns: Конфигурация контекстного меню для данной строки.
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
  
  /// Создает действия для контекстного меню строки таблицы.
  /// - Parameters:
  ///   - tableView: Таблица, для которой создаются действия контекстного меню.
  ///   - indexPath: Для которой создается меню.
  ///   - item: Элемент таблицы, с которым будет связано контекстное меню.
  /// - Returns: Меню с действиями для данной строки.
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
  
  
  /// Обновляет текст с количеством задач на `TabBar`.
  /// - Parameter tabBarController: Контроллер вкладок,
  /// содержащий кастомный `TabBar`и метку для отображения количества задач.
  func updateTodosCountText(tabBarController: CustomTabBarController) {
    tabBarController.tabBar.tintColor = .white
    let todosCountString = String(presenter.todosCount)
    let todosCountTitle = todosCountString + Const.tabBarTaskCountTitleText
    tabBarController.taskCountLabel.text = todosCountTitle
    tabBarController.customTabBarDelegate = self
  }
}

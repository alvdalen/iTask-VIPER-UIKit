//
//  TodoListTableViewCell.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

typealias BaseTodoListCell = BaseTableViewCell<TodoListTableViewCellRootView>
fileprivate typealias Const = TodoListTableViewCellConst

// MARK: - Delegate
/// Протокол делегата для обработки действий в ячейке.
protocol TodoListTableViewCellDelegate: AnyObject {
  /// Вызывается при нажатии на кнопку изменения состояния задачи.
  /// - Parameter todo: Задача, связанная с ячейкой.
  func didTapStateTaskButton(for todo: Todo)
}

// MARK: - TableViewCell
final class TodoListTableViewCell: BaseTodoListCell {
  // MARK: Internal Properties
  weak var delegate: TodoListTableViewCellDelegate?
  var todo: Todo?
  
  // MARK: Internal Methods
  override func setupDelegate() {
    rootView.delegate = self
  }
  
  /// Сдвигает содержимое ячейки влево.
  func moveContentLeft() {
    UIView.animate(withDuration: Const.moveDuration) { [weak self] in
      self?.rootView.stateButtonLeadingConstraint.constant = Const.leftMoveConstant
      self?.rootView.stateButton.alpha = Const.buttonAlphaHidden
      self?.accessoryType = .none
      self?.layoutIfNeeded()
    }
  }
  
  /// Возвращает содержимое ячейки в исходную позицию.
  func restoreContentPosition() {
    rootView.stateButtonLeadingConstraint.constant = Const.rightMoveConstant
    rootView.stateButton.alpha = Const.buttonAlphaVisible
    accessoryType = .disclosureIndicator
    // Без этого метода возвращение к исходному состоянию будет менее плавным.
    layoutIfNeeded()
  }
}

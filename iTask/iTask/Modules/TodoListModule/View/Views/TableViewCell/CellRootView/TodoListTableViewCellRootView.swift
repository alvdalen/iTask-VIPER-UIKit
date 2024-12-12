//
//  TodoListTableViewCellRootView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

fileprivate typealias Const = TodoListTableViewCellRootViewConst

// MARK: - Delegate
protocol TodoListTableViewCellRootViewDelegate: AnyObject {
  func didTapStateTaskButton()
}

// MARK: - RootView
final class TodoListTableViewCellRootView: BaseRootView {
  // MARK: Internal Properties
  weak var delegate: TodoListTableViewCellRootViewDelegate?
  var stateButtonLeadingConstraint: NSLayoutConstraint!
  
  // MARK: Views
  let taskTitleLabel: UILabel = {
    $0.font = Const.titleFont
    return $0
  }(UILabel())
  
  let taskBodyLabel: UILabel = {
    $0.font = Const.taskBodyFont
    $0.numberOfLines = Const.descriptionNumberOfLines
    return $0
  }(UILabel())
  
  let dateLabel: UILabel = {
    $0.font = Const.dateFont
    $0.textColor = Const.dateLabelColor
    return $0
  }(UILabel())
  
  let stateButton: UIButton = {
    $0.setContentHuggingPriority(.required, for: .horizontal)
    $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    $0.transform = CGAffineTransform(
      scaleX: Const.stateButtonScale,
      y: Const.stateButtonScale
    )
    $0.tintColor = GlobalConst.systemColor
    return $0
  }(UIButton())
  
  // MARK: Setup Views
  override func setupViews() {
    addTaskButtonTarget()
    addSubviews()
    setConstraints()
  }
  
  // MARK: Internal Methods
  func configure(
    _ todoTitle: NSAttributedString,
    _ todoBody: String,
    _ todoDate: String,
    _ status: Bool
  ) {
    taskTitleLabel.attributedText = todoTitle
    taskBodyLabel.text = todoBody
    dateLabel.text = todoDate.toLongDate(style: .medium)
    buttonStatus(status)
  }
}

// MARK: - Private Methods
private extension TodoListTableViewCellRootView {
  func addSubviews() {
    addSubview(stateButton)
    addSubview(taskTitleLabel)
    addSubview(taskBodyLabel)
    addSubview(dateLabel)
  }
  
  func setConstraints() {
    setStateButtonConstraints()
    setTaskTitleLabelConstraints()
    setTaskBodyLabelConstraints()
    setDateLabelConstraints()
  }
  
  func setStateButtonConstraints() {
    stateButtonLeadingConstraint = stateButton
      .leadingAnchor
      .constraint(
        equalTo: leadingAnchor,
        constant: Const.defaultPadding
      )
    stateButtonLeadingConstraint.isActive = true
    stateButton.setConstraints(top: topAnchor, pTop: Const.defaultPadding)
  }
  
  func setTaskTitleLabelConstraints() {
    taskTitleLabel.setConstraints(
      top: stateButton.topAnchor,
      leading: stateButton.trailingAnchor,
      trailing: trailingAnchor,
      pLeading: Const.defaultPadding,
      pTrailing: Const.halfDefaultPadding
    )
  }
  
  func setTaskBodyLabelConstraints() {
    taskBodyLabel.setConstraints(
      top: taskTitleLabel.bottomAnchor,
      leading: taskTitleLabel.leadingAnchor,
      trailing: taskTitleLabel.trailingAnchor,
      pTop: Const.minPadding
    )
  }
  
  func setDateLabelConstraints() {
    dateLabel.setConstraints(
      top: taskBodyLabel.bottomAnchor,
      leading: taskTitleLabel.leadingAnchor,
      pTop: Const.halfDefaultPadding
    )
  }
  
  func buttonStatus(_ status: Bool) {
    if !status {
      stateButton.setImage(Const.checkedCircleIcon, for: .normal)
      taskTitleLabel.textColor = Const.uncheckedColor
      taskBodyLabel.textColor = Const.uncheckedColor
      stateButton.tintColor = GlobalConst.systemColor
    } else {
      stateButton.setImage(Const.uncheckedCircleIcon, for: .normal)
      taskTitleLabel.textColor = Const.normalTextColor
      taskBodyLabel.textColor = Const.normalTextColor
      stateButton.tintColor = Const.uncheckedColor
    }
  }
  
  func addTaskButtonTarget() {
    stateButton.addTarget(
      self,
      action: #selector(didTapStateTaskButton),
      for: .touchUpInside
    )
  }
  
  @objc func didTapStateTaskButton(_ sender: UIButton) {
    animateStateTaskButton(sender)
    delegate?.didTapStateTaskButton()
  }
  
  func animateStateTaskButton(_ sender: UIButton) {
    UIView.animate(withDuration: Const.duration) {
      self.scaleDownButton(sender)
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        self.scaleUpButton(sender)
      }
    }
  }
  
  func scaleDownButton(_ sender: UIButton) {
    let scaleTransform = CGAffineTransform(
      scaleX: Const.pressingStateButtonScale,
      y: Const.pressingStateButtonScale
    )
    sender.transform = scaleTransform
  }
  
  func scaleUpButton(_ sender: UIButton) {
    let scaleTransform = CGAffineTransform(
      scaleX: Const.stateButtonScale,
      y: Const.stateButtonScale
    )
    sender.transform = scaleTransform
  }
}

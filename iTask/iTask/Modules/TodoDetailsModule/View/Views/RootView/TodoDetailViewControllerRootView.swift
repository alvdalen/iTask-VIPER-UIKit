//
//  TodoDetailViewControllerRootView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

fileprivate typealias Const = TodoDetailViewControllerRootViewConst

final class TodoDetailViewControllerRootView: BaseRootView {
  // MARK: Internal Views
  let dateLabel: UILabel = {
    $0.textColor = Const.dateLabelColor
    $0.font = Const.dateFont
    $0.textAlignment = .left
    $0.text = Date().toLongDateString(style: .long)
    return $0
  }(UILabel())
  
  let taskTitleTextView: PlaceholderTextView = {
    $0.font = Const.taskHeaderTextViewFont
    $0.isScrollEnabled = false
    $0.textAlignment = .left
    $0.textContainerInset = .zero
    $0.textContainer.lineFragmentPadding = .zero
    $0.placeholder = Const.taskTitlePlaceholderText
    $0.heightAnchor.constraint(
      greaterThanOrEqualToConstant: Const.taskTitleTextViewStartHeight
    ).isActive = true
    return $0
  }(PlaceholderTextView())
  
  let taskBodyTextView: PlaceholderTextView = {
    $0.font = Const.taskBodyTextViewFont
    $0.isScrollEnabled = false
    $0.textAlignment = .justified
    $0.textContainerInset = .zero
    $0.textContainer.lineFragmentPadding = .zero
    $0.placeholder = Const.taskBodyPlaceholderText
    return $0
  }(PlaceholderTextView())
  
  let saveButton: UIButton = {
    $0.setTitle(Const.saveButtonTitle, for: .normal)
    $0.setTitleColor(Const.saveButtonTitleColor, for: .normal)
    $0.titleLabel?.font = Const.saveButtonFont
    $0.layer.cornerRadius = Const.saveButtonCornerRadius
    $0.heightAnchor.constraint(
      equalToConstant: Const.saveButtonHeight
    ).isActive = true
    $0.isEnabled = false
    $0.backgroundColor = GlobalConst.systemColor
    $0.alpha = Const.inactiveButtonAlpha
    return $0
  }(UIButton())
  
  let deleteButton: UIButton = {
    $0.setImage(Const.deleteButtonIcon, for: .normal)
    $0.tintColor = Const.deleteButtonColor
    $0.isEnabled = false
    return $0
  }(UIButton(type: .system))
  
  // MARK: Private Views
  private lazy var lineView: UIView = {
    $0.backgroundColor = Const.lineColor
    $0.heightAnchor.constraint(
      equalToConstant: Const.lineHeight / traitCollection.displayScale
    ).isActive = true
    return $0
  }(UIView())
  
  private lazy var dateIconImageView: UIImageView = {
    $0.image = Const.dateIcon
    $0.heightAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    $0.tintColor = Const.dateLabelColor
    return $0
  }(UIImageView())
  
  private lazy var dateStackView: UIStackView = {
    $0.axis = .horizontal
    $0.spacing = Const.dateStackViewSpacing
   
    $0.addArrangedSubview(dateIconImageView)
    $0.addArrangedSubview(dateLabel)
    return $0
  }(UIStackView())
  
  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.spacing = Const.mainStackViewSpacing
    $0.alignment = .fill
    $0.addArrangedSubview(taskTitleTextView)
    $0.addArrangedSubview(dateStackView)
    $0.addArrangedSubview(lineView)
    $0.addArrangedSubview(taskBodyTextView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(saveButton)
    return $0
  }(UIStackView())
  
  let scrollView: UIScrollView = {
    $0.alwaysBounceVertical = true
    return $0
  }(UIScrollView())
  
  // MARK: Setup Views
  override func setupViews() {
    super.setupViews()
    addSubviews()
    setConstranits()
  }
  
  // MARK: Internal Methods
  func stateSaveButton() {
    let taskTitleTextViewIsEmpty = taskTitleTextView.text.isEmpty
    let taskBodyTextViewIsEmpty = taskBodyTextView.text.isEmpty
    if taskTitleTextViewIsEmpty && taskBodyTextViewIsEmpty {
      inactiveSaveButtonAnimate()
    } else {
      activeSaveButtonAnimate()
    }
  }
  
  // MARK: Private Methods
  private func addSubviews() {
    addSubview(scrollView)
    scrollView.addSubview(mainStackView)
  }
  
  private func setConstranits() {
    setScrollViewConstraints()
    setMainStackViewConstraints()
  }
  
  private func setScrollViewConstraints() {
    scrollView.setConstraints(
      top: safeAreaLayoutGuide.topAnchor,
      bottom: safeAreaLayoutGuide.bottomAnchor,
      leading: safeAreaLayoutGuide.leadingAnchor,
      trailing: safeAreaLayoutGuide.trailingAnchor
    )
  }
  
  private func setMainStackViewConstraints() {
    mainStackView.setConstraints(
      top: scrollView.topAnchor,
      bottom: scrollView.bottomAnchor,
      leading: scrollView.leadingAnchor,
      trailing: scrollView.trailingAnchor,
      pTop: Const.stackViewTopInset,
      pLeading: Const.stackViewHorizontalInset,
      pTrailing: Const.stackViewHorizontalInset
    )
    mainStackView.widthAnchor.constraint(
      equalTo: scrollView.widthAnchor,
      constant: Const.stackViewWidthAdjustment
    ).isActive = true
  }
  
  private func inactiveSaveButtonAnimate() {
    UIView.animate(withDuration: Const.saveButtonAnimateDuration) {
      self.saveButton.alpha = Const.inactiveButtonAlpha
    } completion: { _ in
      self.saveButton.isEnabled = false
    }
  }
  
  private func activeSaveButtonAnimate() {
    UIView.animate(withDuration: Const.saveButtonAnimateDuration) {
      self.saveButton.alpha = Const.activeButtonAlpha
    } completion: { _ in
      self.saveButton.isEnabled = true
    }
  }
}

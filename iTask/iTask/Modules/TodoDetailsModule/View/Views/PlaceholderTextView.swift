//
//  PlaceholderTextView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

final class PlaceholderTextView: UITextView {
  // MARK: Internal Properties
  var placeholder: String? {
    didSet {
      placeholderLabel.text = placeholder
    }
  }
  
  override var text: String! {
    didSet {
      updatePlaceholderVisibility()
    }
  }
  
  override var font: UIFont? {
    didSet {
      placeholderLabel.font = font
    }
  }
  
  // MARK: Views
  private lazy var placeholderLabel: UILabel = {
    $0.textColor = .systemGray3
    $0.font = font
    $0.numberOfLines = .zero
    $0.textAlignment = textAlignment
    $0.isUserInteractionEnabled = false
    return $0
  }(UILabel())
  
  // MARK: Initializers
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    configurePlaceholderLabel()
    delegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Private Methods
  private func configurePlaceholderLabel() {
    addSubview(placeholderLabel)
    placeholderLabel.setConstraints(
      top: topAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor
    )
    updatePlaceholderVisibility()
  }
  
  private func updatePlaceholderVisibility() {
    placeholderLabel.isHidden = !text.isEmpty
  }
}

// MARK: - UITextViewDelegate
extension PlaceholderTextView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    updatePlaceholderVisibility()
  }
}


//
//  PlaceholderTextView.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

import UIKit

/// Кастомный `UITextView`, поддерживающий отображение текста-заглушки, когда текстовое поле пустое.
final class PlaceholderTextView: UITextView {
  // MARK: Internal Properties
  /// Заглушка, отображаемая в пустом текстовом поле.
  var placeholder: String? {
    didSet {
      placeholderLabel.text = placeholder
    }
  }
  
  /// Обновляет видимость заглушки при изменении текста.
  override var text: String! {
    didSet {
      updatePlaceholderVisibility()
    }
  }
  
  /// Переопределение шрифта для текста. Заглушка использует тот же шрифт.
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
  
  /// Обновление видимости метки заглушки в зависимости от наличия текста.
  private func updatePlaceholderVisibility() {
    placeholderLabel.isHidden = !text.isEmpty
  }
}

// MARK: - UITextViewDelegate
extension PlaceholderTextView: UITextViewDelegate {
  /// Метод, вызываемый при изменении текста в текстовом поле.
  func textViewDidChange(_ textView: UITextView) {
    updatePlaceholderVisibility()
  }
}

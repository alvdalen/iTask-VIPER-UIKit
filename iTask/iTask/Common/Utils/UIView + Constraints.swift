//
//  UIView + Constraints.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

extension UIView {
  func setConstraints(
    top: NSLayoutYAxisAnchor? = nil,
    bottom: NSLayoutYAxisAnchor? = nil,
    leading: NSLayoutXAxisAnchor? = nil,
    trailing: NSLayoutXAxisAnchor? = nil,
    centerY: NSLayoutYAxisAnchor? = nil,
    centerX: NSLayoutXAxisAnchor? = nil,
    pTop: CGFloat = .zero,
    pBottom: CGFloat = .zero,
    pLeading: CGFloat = .zero,
    pTrailing: CGFloat = .zero,
    pCenterY: CGFloat = .zero,
    pCenterX: CGFloat = .zero
  ) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(
        equalTo: top,
        constant: pTop
      ).isActive = true
    }
    
    if let trailing = trailing {
      trailingAnchor.constraint(
        equalTo: trailing,
        constant: -pTrailing
      ).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(
        equalTo: bottom,
        constant: -pBottom
      ).isActive = true
    }
    
    if let leading = leading {
      leadingAnchor.constraint(
        equalTo: leading,
        constant: pLeading
      ).isActive = true
    }
    
    if let centerY = centerY {
      centerYAnchor.constraint(
        equalTo: centerY,
        constant: pCenterY
      ).isActive = true
    }
    
    if let centerX = centerX {
      centerXAnchor.constraint(
        equalTo: centerX,
        constant: pCenterX
      ).isActive = true
    }
  }
  
  func fillSuperView(widthPadding: CGFloat = .zero) {
    guard let superview = self.superview else { return }
    setConstraints(
      top: superview.topAnchor,
      bottom: superview.bottomAnchor,
      leading: superview.leadingAnchor,
      trailing: superview.trailingAnchor,
      pTop: widthPadding,
      pBottom: widthPadding,
      pLeading: widthPadding,
      pTrailing: widthPadding
    )
  }
  
  func centerY() {
    guard let superview = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
  }
  
  func centerX() {
    guard let superview = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
  }
  
  func centerXY() {
    centerY()
    centerX()
  }
}

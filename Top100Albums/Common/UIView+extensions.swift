//
//  UIView+extensions.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/9/21.
//

import Foundation
import UIKit

extension UIView {
    func pin(height: CGFloat? = nil, width: CGFloat? = nil) {
        enableAutoLayout()
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }

    func pinToSuperView(leading: CGFloat = 0.0,
                        trailing: CGFloat = 0.0,
                        top: CGFloat = 0.0,
                        bottom: CGFloat = 0.0) {
        enableAutoLayout()
        pin(leading: leading, top: top, trailing: trailing, bottom: bottom)
    }

    private func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func pin(leading: CGFloat? = nil,
             top: CGFloat? = nil,
             trailing: CGFloat? = nil,
             bottom: CGFloat? = nil) {

        guard let superview = superview else { return }
        enableAutoLayout()
        if let leading = leading {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        }
    }

    func pinToSafeArea(leading: CGFloat? = nil,
                       top: CGFloat? = nil,
                       trailing: CGFloat? = nil,
                       bottom: CGFloat? = nil) {

        guard let superviewSafeGuide = superview?.safeAreaLayoutGuide else { return }
        enableAutoLayout()

        if let leading = leading {
            leadingAnchor.constraint(equalTo: superviewSafeGuide.leadingAnchor, constant: leading).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: superviewSafeGuide.topAnchor, constant: top).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: superviewSafeGuide.trailingAnchor, constant: -trailing).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: superviewSafeGuide.bottomAnchor, constant: -bottom).isActive = true
        }

    }

    func pinToSuperviewCenter(offsetX: CGFloat? = nil, offsetY: CGFloat? = nil) {
        guard let superview = superview else { return }
        enableAutoLayout()

        if let offsetX = offsetX {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offsetX).isActive = true
        }

        if let offsetY = offsetY {
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offsetY).isActive = true
        }
    }
    
}


extension UIStackView {
    func addArrangedSubviews(_ arrangedViews: UIView...) {
        arrangedViews.forEach(addArrangedSubview(_:))
    }
}

extension UILabel {
    static func multiLineLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
}

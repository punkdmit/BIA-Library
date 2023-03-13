//
//  Extensions.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 20.02.2023.
//
import UIKit
import Foundation

extension UIButton {
    func setImage(image: UIImage?) {
        for state: UIControl.State in [.normal, .selected, .application, .disabled, .focused, .highlighted, .reserved] {
            setImage(image, for: state)
        }
    }
}

extension UIView {
    func aplyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}

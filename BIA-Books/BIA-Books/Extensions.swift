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
        layer.shadowOpacity = 0.12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}
extension UITableViewCell {
    func noSelectionStyle () {
        self.selectionStyle = .none
    }
}
extension UIStackView {
    func roundCornersForUILabels() {
        self.layer.cornerRadius = 6
        self.layer.cornerCurve = .continuous
    }
}
//extension UIStackView {
//    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
//        let subView = UIView(frame: bounds)
//        subView.backgroundColor = backgroundColor
//        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        insertSubview(subView, at: 0)
//
//        subView.layer.cornerRadius = radiusSize
//        subView.layer.masksToBounds = true
//        subView.clipsToBounds = true
//    }
//}


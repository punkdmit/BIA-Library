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

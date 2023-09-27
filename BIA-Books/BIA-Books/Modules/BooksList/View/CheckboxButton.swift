//
//  CheckBoxButton.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 11.05.2023.
//

import UIKit

class CheckBox: UIButton {
    
    let checkedImage = UIImage(systemName: "checkmark.square")
    let uncheckedImage = UIImage(systemName: "square")
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
//        self.layer.borderColor = UIColor(ciColor: .white).cgColor
        
    }
    
    @objc func buttonClicked(sender: UIButton) {
        isChecked = !isChecked
    }
}



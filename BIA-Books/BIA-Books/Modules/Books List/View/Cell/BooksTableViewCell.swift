//
//  BooksTableViewCell.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 10.03.2023.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    let selectedColorView = UIView()
    
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var bookStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.aplyShadow(cornerRadius: 12)
        setUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setShadow(stack : UIStackView) {
        stack.layer.cornerRadius = 12
        stack.layer.masksToBounds = false
        stack.layer.shadowRadius = 4.0
        stack.layer.shadowOpacity = 0.30
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    private func setUp() {
        roundCornersForUILabels(label: language)
        roundCornersForUILabels(label: bookStatus)
        roundCornersForUILabels(label: bookName)
        
    }
    private func roundCornersForUILabels(label: UILabel) {
        label.layer.cornerRadius = 6
        label.layer.cornerCurve = .continuous
    }
}

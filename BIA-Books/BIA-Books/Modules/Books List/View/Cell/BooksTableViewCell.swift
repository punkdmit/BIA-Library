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
    
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var bookStatus: UILabel!
    
    @IBOutlet weak var dateStack: UIStackView!
    @IBOutlet weak var languageStack: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    private func setUp() {
        cardView.aplyShadow(cornerRadius: 12)
        roundCornersForUILabels(stack: dateStack)
        roundCornersForUILabels(stack: languageStack)
        
    }
    
    private func roundCornersForUILabels(stack: UIStackView) {
        stack.layer.cornerRadius = 6
        stack.layer.cornerCurve = .continuous
    }
}

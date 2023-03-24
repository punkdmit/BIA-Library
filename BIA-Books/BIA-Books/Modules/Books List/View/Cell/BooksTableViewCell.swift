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
        dateStack.roundCornersForUILabels(radius: 6)
        languageStack.roundCornersForUILabels(radius: 6)
    }
}

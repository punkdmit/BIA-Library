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
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var amountOfRates: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var bookStatus: UILabel!
    
    @IBOutlet weak var dateStack: UIStackView!
    @IBOutlet weak var languageStack: UIStackView!
    
     var viewModel : BookListCellViewModel? {
        willSet(viewModel) {
            bookName.text = viewModel?.name
            language.text = viewModel?.language
            author.text = viewModel?.author
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    private func setUp() {
        cardView.aplyShadow(cornerRadius: 12)
        dateStack.roundCornersForUILabels(radius: 6)
        languageStack.roundCornersForUILabels(radius: 6)
        self.noSelectionStyle()
        
    }
}

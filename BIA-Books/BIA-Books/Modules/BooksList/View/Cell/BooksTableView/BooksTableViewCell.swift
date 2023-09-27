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
    
    @IBOutlet var stars: [UIImageView]!
    
    @IBOutlet weak var dateStack: UIStackView!
    @IBOutlet weak var languageStack: UIStackView!
    
    var viewModel : BookListCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        bookName.text = viewModel.name
        bookCover.image = viewModel.image
        language.text = viewModel.language
        author.text = viewModel.author
        setupStatus(status: viewModel.status )
        showStars(count: convertFirstCharacterToInt(string: viewModel.rate ) ?? 0)
    }
    
    private func setUp() {
        cardView.aplyShadow(cornerRadius: 12)
        dateStack.roundCornersForUILabels(radius: 6)
        languageStack.roundCornersForUILabels(radius: 6)
        self.noSelectionStyle()
        bookCover.roundedCornerButton(radius: 6)
        amountOfRates.text = ""
    }
    
    func setupStatus(status: Bool) {
        switch status {
        case true:
            dateStack.backgroundColor = BooksColor.textSecondary
            bookStatus.text = "Недоступна"

        case false:
            dateStack.backgroundColor = BooksColor.accentSucces
            bookStatus.text = "Свободна"
        }
    }
    
    func showStars(count: Int) {
        for (index, starImageView) in stars.enumerated() {
            if index <= count {
                starImageView.image = UIImage(named: "starFill")
            } else {
                starImageView.image = UIImage(named: "star")
            }
        }
    }
    
    func convertFirstCharacterToInt(string: String) -> Int? {
        guard let firstCharacter = string.first else {
            return nil
        }
        return Int(String(firstCharacter))
    }
}

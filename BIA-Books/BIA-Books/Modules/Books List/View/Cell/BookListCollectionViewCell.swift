//
//  BookListCollectionViewCell.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 04.04.2023.
//

import UIKit

class BookListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    // Clear cell data
    override func prepareForReuse() {
        super.prepareForReuse()
        tagName.text = nil
        set(isSelected: false)
    }
    
    private func setup() {
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }
    
    func set(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = BooksColor.textPrimary
            self.tagName.textColor = BooksColor.brandTertiary
        } else {
            self.backgroundColor = BooksColor.backgroundSecondary
            self.tagName.textColor = BooksColor.textPrimary
        }
    }
}

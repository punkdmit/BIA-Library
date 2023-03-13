//
//  BookCardCell.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import UIKit

class BookCardCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var viewModel: CardViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindViewModel()
        setup()
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
    }

    func setup() {
        self.bookImage.image = viewModel?.myShelf.bookImage
        self.bookNameLabel.text = viewModel?.myShelf.bookName
        self.authorLabel.text = viewModel?.myShelf.authorName
//        self.bookImage.image = i?.bookImage
//        self.bookNameLabel.text = i?.bookNam
//        self.authorLabel.text = i?.bookName
    }
}

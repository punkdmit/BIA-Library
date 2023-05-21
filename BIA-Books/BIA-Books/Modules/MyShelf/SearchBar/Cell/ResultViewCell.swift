//
//  ResultTableViewCell.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 17.03.2023.
//

import UIKit

class ResultViewCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var viewModel: BookCardViewModel?
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        bookImage.image = viewModel.bookImage
        bookNameLabel.text = viewModel.bookName
        authorLabel.text = viewModel.authorName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        bookImage.layer.cornerRadius = 4
        selectionStyle = .none
    }
}

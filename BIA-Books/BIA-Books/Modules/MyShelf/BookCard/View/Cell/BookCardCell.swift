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
    
    @IBOutlet weak var view: UIView!
    
    weak var viewModel: CardViewModel? {
        willSet(viewModel) {
            bookImage.image = viewModel?.bookImage
            bookNameLabel.text = viewModel?.bookName
            authorLabel.text = viewModel?.authorname
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        bindViewModel()
        setup()
    }
    
//    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
//    }

    func setup() {
        bookImage.layer.cornerRadius = 8
        bookImage.layer.cornerCurve = .continuous
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 12
    }
}

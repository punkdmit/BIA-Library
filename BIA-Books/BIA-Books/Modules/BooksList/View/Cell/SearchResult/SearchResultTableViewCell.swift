//
//  SearchResultTableViewCell.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 24.05.2023.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
    
    var viewModel : BookListCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.noSelectionStyle()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        bookCover.image = viewModel.image
        name.text = viewModel.name
        author.text = viewModel.author
    }
}

//
//  BooksTableViewCell.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 10.03.2023.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        aplyShadow(cornerRadius: 12)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

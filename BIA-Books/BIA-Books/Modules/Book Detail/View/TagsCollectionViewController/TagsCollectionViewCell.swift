//
//  TagsCollectionViewCell.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 24.03.2023.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }

}

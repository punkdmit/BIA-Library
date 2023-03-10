//
//  MyShelfViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import Foundation
import UIKit

class MyShelfViewModel {
    private var shelfBookCards: [ShelfBookCard]
    
    var bookImage: UIImage? {
        return shelfBookCards[$0]
    }
    
    var bookName: String? {
        return shelfBookCards.bookName
    }
    
    var author: String? {
        return shelfBookCards.author
    }
    
    init(shelfBookCard: ShelfBookCard) {
        self.shelfBookCard = shelfBookCard
    }
}

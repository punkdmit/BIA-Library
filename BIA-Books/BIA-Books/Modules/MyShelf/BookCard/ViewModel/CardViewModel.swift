//
//  CardViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import Foundation
import UIKit

class CardViewModel {
    
    var book: Book?
    
    var bookImage: UIImage? {
        return book?.bookImage
    }
    
    var bookName: String? {
        return book?.bookName
    }
    
    var authorName: String? {
        return book?.authorName
    }
    
    var bookStatus: String? {
        return book?.bookStatus
    }
    
    init(myShelf: Book) {
        self.book = myShelf
    }
}



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
    
    var authorname: String? {
        return book?.authorName
    }
    
    init(myShelf: Book) {
        self.book = myShelf
    }
}



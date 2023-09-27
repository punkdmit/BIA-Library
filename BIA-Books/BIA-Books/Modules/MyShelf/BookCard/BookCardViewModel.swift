//
//  CardViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import Foundation
import UIKit

class BookCardViewModel {
    enum CellType {
        case requested
        case reading
        case returned
    }
    
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
    
    var cellType: CellType
    
//    var bookStatus: String? {
//        return book?.bookStatus
//    }
    
    init(myShelf: Book, cellType: CellType) {
        self.book = myShelf
        self.cellType = cellType
    }
}



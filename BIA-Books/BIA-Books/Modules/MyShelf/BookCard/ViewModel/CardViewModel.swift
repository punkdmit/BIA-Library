//
//  CardViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import Foundation
import UIKit

class CardViewModel {
    
    var myShelf: MyShelf
    
    var bookImage: UIImage? {
        return myShelf.bookImage
    }
    
    var bookName: String? {
        return myShelf.bookName
    }
    
    var authorname: String? {
        return myShelf.authorName
    }
    
    init(myShelf: MyShelf) {
        self.myShelf = myShelf
    }
    
    
}



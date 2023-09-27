//
//  MyShelf.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import Foundation
import UIKit

enum BooksStatuses {
    case requested
    case reading
    case read
}

struct Book {
    let bookId: String?
    let bookImage: UIImage?
    let bookName: String
    let authorName: String?
    let bookStatus: Bool?
}




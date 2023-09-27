//
//  BookListCellViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 04.05.2023.
//

import UIKit

class BookListCellViewModel {
    
    var _id: String {
        return book.id ?? ""
    }
    
    var name: String {
        return book.name ?? ""
    }
    
    var author: String {
        return book.author ?? ""
    }
    
    var language: String {
        return book.language ?? ""
    }
    
    var description: String {
        return book.description ?? ""
    }
    
    var status: Bool {
        return book.status ?? false
    }
    
    var image: UIImage? {
        guard let imageData = book.image,
        let dataDecoded = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: dataDecoded)
    }
    
    var rate: String {
        return book.rate ?? ""
    }
    
    private var book : BookList
    
    init(book: BookList) {
        self.book = book
    }
}

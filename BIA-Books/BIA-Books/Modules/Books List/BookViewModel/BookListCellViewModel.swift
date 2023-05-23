//
//  BookListCellViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 04.05.2023.
//

import Foundation

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
    
    var status: String {
        return book.status ?? ""
    }
    
    var image: String {
        return book.image ?? ""
    }
    
    private var book : BookList
    
    init(book : BookList) {
        self.book = book
    }
}

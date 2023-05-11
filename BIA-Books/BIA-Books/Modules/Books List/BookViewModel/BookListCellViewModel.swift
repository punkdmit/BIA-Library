//
//  BookListCellViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 04.05.2023.
//

import Foundation

class BookListCellViewModel {
    
    //добавить несколько Dynamic переменных для отслеживания вводится ли что-то в поисковую строку и что вводится в эту строку
    //var isSearching = Dynamic(false)
    //var searchContent : Dynamic<Stung?> = Dynamic(nil)
    
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

//
//  BookDetailViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 30.03.2023.
//

import Foundation


class BookDetailViewModel  : ViewModelDetailType  {
    
    var pickedBook : Dynamic<BookInfo?> = Dynamic(nil)
    var reservationError : Dynamic<String?> = Dynamic(nil)
    var bookId: String
    
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
    
    var labels: [String]?
    
    init(bookId: String) {
        self.bookId = bookId
        loadBookInfo(bookId: bookId)
    }
    
    func numberOfRows() -> Int {
        return labels?.count ?? 0
    }
    
    private func loadBookInfo(bookId : String) {
        fetcher.getBookInfo(params: ["bookId" : bookId]) { [weak self] bookDetail in
            if let book = bookDetail {
                self?.pickedBook.value = book
            }
        }
    }
    
    func reserveBook() {
        fetcher.reserve(params: ["bookId" : bookId], response: { [weak self] statusCode, message in
            if statusCode != 200 {
                self?.reservationError.value = message
            }
        })
    }
}


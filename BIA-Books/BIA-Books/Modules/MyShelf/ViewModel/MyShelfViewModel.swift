//
//  MyShelfViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 13.03.2023.
//

import Foundation
import UIKit

class MyShelfViewModel {
    private let dataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    var dataSource: Dynamic<[Book]?> = Dynamic(nil)
    
    enum BookSection {
        case myShelf(books: [Book])
        case other(books: [Book])
    }
    var allBooksDataSource: Dynamic<[Book]?> = Dynamic(nil)
    
    var isSearching: Bool = false
    var searchText: String?
    
    var booksPreset: Dynamic<[Book]?> = Dynamic([
        Book(bookId: "1", bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read),
        Book(bookId: "2", bookImage: UIImage(named: "Обложка"), bookName: "Язык Swift", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read),
        Book(bookId: "3", bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read)
    ])
        
    func getRequestedBooksList() {
        dataFetcher.getRequestedBooksList { [weak self] bookList in
            let newBookList = bookList.compactMap {
                var decodedImage: UIImage?
                
                if let imageData = $0?.image {
                    let dataDecoded: Data = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters)!
                    decodedImage = UIImage(data: dataDecoded)
                }
                
                return Book(bookId: $0?.id, bookImage: decodedImage, bookName: $0?.name ?? "", authorName: $0?.author, bookStatus: nil)
            }
            self?.dataSource.value = newBookList
            self?.allBooksDataSource.value = newBookList
        }
    }
    
    func getRentedBooksList() {
        dataFetcher.getRentedBooksList { [weak self] bookList in
            let newBookList = bookList.compactMap {
                var decodedImage: UIImage?
                
                if let imageData = $0?.image {
                    let dataDecoded: Data = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters)!
                    decodedImage = UIImage(data: dataDecoded)
                }
                
                return Book(bookId: $0?.id, bookImage: decodedImage, bookName: $0?.name ?? "", authorName: $0?.author, bookStatus: nil)
            }
            self?.dataSource.value = newBookList
            self?.allBooksDataSource.value = newBookList
        }
    }
    
    func cancelBookRequest(bookId: String) {
        dataFetcher.cancelBookRequest(params: ["bookId" : bookId], response: { [weak self] statusCode in
            if statusCode == 200 {
                self?.getRequestedBooksList()
            }
            
        })
    }
    
    func cancelBookRent(bookId: String) {
        dataFetcher.cancelBookRent(params: ["bookId" : bookId], response: { [weak self] statusCode in
            if statusCode == 200 {
                self?.getRentedBooksList()
            }
        })
    }
    
    func reserve(bookId: String) {
        dataFetcher.reserve(params: ["bookId" : bookId], response: { [weak self] statusCode in
            if statusCode == 200 {
//                self?.getRequestedBooksList()
            }
        })
    }
}

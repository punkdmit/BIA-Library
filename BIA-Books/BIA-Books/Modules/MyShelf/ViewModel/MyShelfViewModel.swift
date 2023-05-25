//
//  MyShelfViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 13.03.2023.
//

import Foundation
import UIKit

class MyShelfViewModel {
    enum BookSection {
            case myShelf(books: [Book])
            case other(books: [Book])
    }
    
    private let dataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    var dataSource: Dynamic<[Book]?> = Dynamic(nil)
    var allBooksDataSource: Dynamic<[Book]?> = Dynamic(nil)
    var reserveError: Dynamic<String?> = Dynamic(nil)
    
    var isSearching: Bool = false
    var searchText: String?
        
    func getRequestedBooksList() {
        dataFetcher.getRequestedBooksList { [weak self] bookList in
            let newBookList = bookList.compactMap {
                var decodedImage: UIImage?
                
                if let imageData = $0?.image {
                    if let dataDecoded = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) {
                        let dataDecoded: Data = dataDecoded
                        decodedImage = UIImage(data: dataDecoded)
                    }
                }
                
                return Book(bookId: $0?.id, bookImage: decodedImage, bookName: $0?.name ?? "", authorName: $0?.author, bookStatus: $0?.status)
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
                    if let dataDecoded = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) {
                        let dataDecoded: Data = dataDecoded
                        decodedImage = UIImage(data: dataDecoded)
                    }
                }
                
                return Book(bookId: $0?.id, bookImage: decodedImage, bookName: $0?.name ?? "", authorName: $0?.author, bookStatus: $0?.status)
            }
            self?.dataSource.value = newBookList
            self?.allBooksDataSource.value = newBookList
        }
    }
    
    func getReturnedBooksList() {
        dataFetcher.getReturnedBooksList { [weak self] bookList in
            let newBookList = bookList.compactMap {
                var decodedImage: UIImage?
                
                if let imageData = $0?.image {
                    if let dataDecoded = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) {
                        let dataDecoded: Data = dataDecoded
                        decodedImage = UIImage(data: dataDecoded)
                    }
                }
                
                return Book(bookId: $0?.id, bookImage: decodedImage, bookName: $0?.name ?? "", authorName: $0?.author, bookStatus: $0?.status)
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
        dataFetcher.reserve(params: ["bookId" : bookId], response: { [weak self] statusCode, message in
            if statusCode != 200 {
                self?.reserveError.value = message
            }
        })
    }
}


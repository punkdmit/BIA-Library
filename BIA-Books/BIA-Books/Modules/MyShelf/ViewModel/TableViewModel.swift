//
//  TableViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 13.03.2023.
//

import Foundation
import UIKit

class ViewModel {
    private let dataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    var dataSource: Dynamic<[Book]?> = Dynamic(nil)
    
    enum BookSection {
        case myShelf(books: [Book])
        case other(books: [Book])
    }
    
    var isSearching: Bool = false
    var searchText: String?
    
    var booksPreset: Dynamic<[Book]?> = Dynamic([
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Дежавю", authorName: "Кизару", bookStatus: BooksStatuses.requested),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Разработка по кайфу", authorName: "Программист обычный", bookStatus: BooksStatuses.requested),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "iOS приложения бомбовые", authorName: "Кизару", bookStatus: BooksStatuses.requested),

        Book(bookImage: UIImage(named: "Обложка"), bookName: "Букварь", authorName: "Микки Маус", bookStatus: BooksStatuses.reading),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Павел Попов: Биография легенды разработки", authorName: "Павел Попов", bookStatus: BooksStatuses.reading),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Апенько Дима: с 0 до сеньора", authorName: "Апенько Дмитрий", bookStatus: BooksStatuses.reading),
        
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык Swift", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read)
    ])
        
    func getRequestedBooksList() {
        dataFetcher.getRequestedBooksList { [weak self] bookList in
            let newBookList = bookList.compactMap {
                var decodedImage: UIImage?
                
                if let imageData = $0?.image {
                    let dataDecoded: Data = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters)!
                    decodedImage = UIImage(data: dataDecoded)
                }
                
                return Book(bookImage: decodedImage, bookName: $0?.name ?? "", authorName: $0?.author, bookStatus: nil)
            }
            
            self?.dataSource.value = newBookList
        }
    }
}


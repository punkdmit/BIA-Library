//
//  TableViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 13.03.2023.
//

import Foundation
import UIKit

class ViewModel {
    var booksPreset = [
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Дежавю", authorName: "Кизару", bookStatus: BooksStatuses.requested),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Разработка по кайфу", authorName: "Программист обычный", bookStatus: BooksStatuses.requested),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "iOS приложения бомбовые", authorName: "Кизару", bookStatus: BooksStatuses.requested),

        Book(bookImage: UIImage(named: "Обложка"), bookName: "Букварь", authorName: "Микки Маус", bookStatus: BooksStatuses.reading),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Павел Попов: Биография легенды разработки", authorName: "Павел Попов", bookStatus: BooksStatuses.reading),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Апенько Дима: с 0 до сеньора", authorName: "Апенько Дмитрий", bookStatus: BooksStatuses.reading),
        
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык Swift", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никита Аликан", bookStatus: BooksStatuses.read)
    ]
    
    var dataSource = [Book]()
    
    enum BookSection {
        case myShelf(books: [Book])
        case other(books: [Book])
    }
//    var searchDataSource = BookSection
    
    var isSearching: Bool = false
    var searchText: String?

    func cellViewModel(indexPath: IndexPath, type: CardViewModel.CellType) -> CardViewModel? {
        let book = dataSource[indexPath.row]
        return CardViewModel(myShelf: book, cellType: type)
    }
}


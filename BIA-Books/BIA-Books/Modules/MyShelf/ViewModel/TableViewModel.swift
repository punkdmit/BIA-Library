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
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Букварь", authorName: "Микки Маус", bookStatus: BooksStatuses.reading),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никитос Аликан", bookStatus: BooksStatuses.read)
    ]
    
    var dataSource = [Book]()
    
    func cellViewModel(indexPath: IndexPath, type: CardViewModel.CellType) -> CardViewModel? {
        let book = dataSource[indexPath.row] 
        return CardViewModel(myShelf: book, cellType: type)
    }
}

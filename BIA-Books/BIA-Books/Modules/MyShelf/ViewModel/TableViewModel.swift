//
//  TableViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 13.03.2023.
//

import Foundation
import UIKit

class ViewModel {
    enum BooksStatuses: String {
        case requested
        case reading
        case read
    }
    
    var myShelfs = [
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Дежавю", authorName: "Кизару", bookStatus: BooksStatuses.requested.rawValue),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Букварь", authorName: "Микки Маус", bookStatus: BooksStatuses.reading.rawValue),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никитос Аликан", bookStatus: BooksStatuses.read.rawValue)
    ]
    
    func cellViewModel(indexPath: IndexPath) -> CardViewModel? {
        let myShelf = myShelfs[indexPath.row] 
        return CardViewModel(myShelf: myShelf)
    }
}

//
//  TableViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 13.03.2023.
//

import Foundation
import UIKit

class ViewModel {
    var myShelfs = [
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Дежавю", authorName: "Кизару"),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Букварь", authorName: "Микки Маус"),
        Book(bookImage: UIImage(named: "Обложка"), bookName: "Язык программирования Swift для чайников", authorName: "Дима Апенько, Попов Павел, Никитос Аликан")
    ]
    
    func cellViewModel(indexPath: IndexPath) -> CardViewModel? {
        let myShelf = myShelfs[indexPath.row] 
        return CardViewModel(myShelf: myShelf)
    }
}

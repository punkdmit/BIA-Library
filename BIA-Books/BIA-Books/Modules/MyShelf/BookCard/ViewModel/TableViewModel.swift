//
//  TableViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 13.03.2023.
//

import Foundation
import UIKit

class ViewModel {
//    private var selectedIndexPath : IndexPath?

    var myShelfs = [
        MyShelf(bookImage: UIImage(named: "1"), bookName: "Дежавю", authorName: "Кизару"),
        MyShelf(bookImage: UIImage(named: "1"), bookName: "Букварь", authorName: "Микки Маус"),
        MyShelf(bookImage: UIImage(named: "1"), bookName: "Язык программирования Swift", authorName: "Дима Апенько")
    ]
    
    func cellViewModel(indexPath: IndexPath) -> CardViewModel? {
        let myShelf = myShelfs[indexPath.row] 
        return CardViewModel(myShelf: myShelf)
    }
}

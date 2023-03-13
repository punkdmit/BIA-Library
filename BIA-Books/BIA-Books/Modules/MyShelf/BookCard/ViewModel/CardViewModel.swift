//
//  CardViewModel.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import Foundation
import UIKit

class CardViewModel {
    private var selectedIndexPath : IndexPath?

    var myShelfs: [MyShelf]? = [
        MyShelf(bookImage: UIImage(named: "1"), bookName: "Дежавю", authorName: "Кизару"),
        MyShelf(bookImage: UIImage(named: "1"), bookName: "Букварь", authorName: "Микки Маус"),
        MyShelf(bookImage: UIImage(named: "1"), bookName: "Язык программирования Swift", authorName: "Дима Апенько")
        ]
    
    var myShelf: MyShelf
    
    init(myShelf: MyShelf) {
        self.myShelf = myShelf
    }
    
    func cellViewModel(indexPath: IndexPath) -> CardViewModel? {
        guard let myShelf = myShelfs?[indexPath.row] else { return nil }
        return CardViewModel(myShelf: myShelf)
    }
}



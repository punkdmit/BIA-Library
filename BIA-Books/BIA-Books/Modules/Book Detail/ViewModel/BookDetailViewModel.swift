//
//  BookDetailViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 30.03.2023.
//

import Foundation


class BookDetailViewModel  :ViewModelDetailType  {
    func numberOfRows() -> Int {
        return labels.count
    }
    
    
    var labels = ["Дизайн",  "Разработка", "1С"]
    

    
}


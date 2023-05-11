//
//  BookListModelType.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 04.05.2023.
//

import Foundation

protocol BookListModelType {
    func numberOfTags() -> Int
    var bookList: Dynamic<[BookList]?> {get set}
    
//    func viewModelForSelectedRow() -> ViewModelDetailType?
    func selectRow(indexPath: IndexPath)
}

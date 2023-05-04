//
//  BookListModelType.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 04.05.2023.
//

import Foundation

protocol BookListModelType {
    func numberOfRows() -> Int
    func numberOfTags() -> Int
    func cellViewModel(indexPath : IndexPath) -> BookListCellViewModelType?
    var bookList: Dynamic<[BookList]> {get set}
    
}

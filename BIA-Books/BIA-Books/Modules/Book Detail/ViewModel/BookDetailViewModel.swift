//
//  BookDetailViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 30.03.2023.
//

import Foundation


class BookDetailViewModel  : ViewModelDetailType  {
    
    private var fetcher = NetworkDataFetcher(networking: NetworkService())

    func numberOfRows() -> Int {
        return labels.count
    }
    
    
    var labels = ["Дизайн",  "Разработка", "1С"]
    
    func loadBookInfo() {
        fetcher.getBookInfo(params: ["bookId" : "6450fdf9f2393509a5d29c1b"]) { response in
            
        }
    }
    

    
}


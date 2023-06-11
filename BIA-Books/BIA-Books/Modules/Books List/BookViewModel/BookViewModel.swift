//
//  BookViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 06.03.2023.
//

import Foundation

class BooksViewModel : BookListModelType {
    
    private var selectedIndexPath : IndexPath?
    
    var bookList: Dynamic<[BookList]?> = Dynamic(nil)
    var dataSource: Dynamic<[BookList]?> = Dynamic(nil)
    
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
    let bookListTags = ["Дизайн", "1C", "Разработка", "Тестирование", "Системный анализ", "Управление проектами", "Бухгалтерия"]
    
    var isSearching: Dynamic<Bool?> = Dynamic(false)
    var searchText: Dynamic<String?> = Dynamic(nil)
    
    func numberOfTags() -> Int {
        return bookListTags.count
    }
    
    func numberOfRows() -> Int {
        return self.bookList.value?.count ?? 0
    }
    
    func loadBookList() {
        fetcher.getBookList(params: [:]) { [weak self] response in
            
            let books = response.compactMap { $0 }
            if !books.isEmpty {
                self?.bookList.value = books
                self?.dataSource.value = books
            } else {
                print("Не удалось загрузить список книг")
            }
        }
    }
    
    func viewModelForSelectedRow() -> ViewModelDetailType? {
        return nil
    }
    
    func resetFilter() {
        filterByTag(nil)
    }
    
    func selectRow(indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    func filterByTag(_ tag: String?) {
        dataSource.value = bookList.value?.filter {
            if let tag = tag {
                return $0.tags?.contains(tag) ?? false
            } else {
                return true
            }
        }
    }
}

//
//  MyShelfViewController.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import UIKit

class MyShelfViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        setSegment(index: sender.selectedSegmentIndex)
    }
    
    private let searchController = UISearchController(searchResultsController: nil)

    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        bindViewModel()
        
        tableView.register(UINib(nibName: "RequestedBookCardCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "ResultViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavigationControllerTitle()
        setupSearchController()
        setupNavigationControllerSortImage()
        setSegment(index: 0)
    }
    
    func bindViewModel() {
        viewModel?.dataSource.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func setupNavigationControllerTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Моя полка"
//        navigationController?.navigationBar.tintColor = BooksColor.textPrimary ??????????????
    }
    
    func setupNavigationControllerSortImage() {
        let button = UIBarButtonItem(image: UIImage(named: "Slider"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = button
        navigationItem.rightBarButtonItem?.tintColor = BooksColor.textPrimary
    }
    
    func setupSearchController() {
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setSegment(index: Int) {
        switch index {
        case 0:
            viewModel?.getRequestedBooksList()
        case 1:
            viewModel?.getRentedBooksList()
        case 2:
            viewModel?.dataSource.value = viewModel?.booksPreset.value?.filter{ $0.bookStatus == .read } ?? []
        default:
            viewModel?.dataSource.value = []
        }
        
//        tableView.reloadData()
    }
}

extension MyShelfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if ((viewModel?.isSearching) != false) {
//            return
//        }
        return viewModel?.dataSource.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellType: CardViewModel.CellType?
        
        switch(mySegmentControl.selectedSegmentIndex) {
        case 0:
            cellType = .requested
        case 1:
            cellType = .reading
        case 2:
            cellType = .read
        default:
            cellType = nil
        }
        
        switch viewModel?.isSearching {
        case false:
            guard let cellType = cellType, let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookCardCell else { return UITableViewCell() }
            
            guard let dataSource = viewModel?.dataSource.value else { return UITableViewCell() }
            let book = dataSource[indexPath.row]
            cell.viewModel = CardViewModel(myShelf: book, cellType: cellType)
            cell.bindViewModel()
            return cell
            
        case true:
            guard let cellType = cellType, let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultViewCell else { return UITableViewCell() }
            
            guard let dataSource = viewModel?.dataSource.value else { return UITableViewCell() }
            let book = dataSource[indexPath.row]
            cell.viewModel = CardViewModel(myShelf: book, cellType: cellType)
            cell.bindViewModel()
            /*
            let cellViewModel = viewModel?.cellViewModel(indexPath: indexPath, type: cellType)
            cell.viewModel = cellViewModel
            cell.bindViewModel()
            */
            return cell
            
        default:
            return UITableViewCell() //МОЖНО СДЕЛАТЬ ЕНАМ СО СВОИМ ПЕРЕЧИСЛЕНИЕМ ТРУ ФОЛС И ТОГДА НЕ БУДЕТ ДЕФОЛТА
        }
    }
}

// МЕТОД ДЛЯ СЕРЧ КОНТРЛОЛЛЕРА КОТОРЫЙ СМОТРИТ НА ВВЕДЕННЫЙ ТЕКСТ В СТРОКУ
extension MyShelfViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != viewModel?.searchText {
            viewModel?.searchText = searchController.searchBar.text
            filterContentForSearchText(searchController.searchBar.text ?? "")
        }
        
        viewModel?.isSearching = !(searchController.searchBar.text?.isEmpty ?? true)
        
        if viewModel?.isSearching == true {
            mySegmentControl.isHidden = true
        } else {
            mySegmentControl.isHidden = false
        }
        
        tableView.reloadData()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel?.dataSource = Dynamic(viewModel?.booksPreset.value?.filter { (book: Book) -> Bool in
            return book.bookName.lowercased().contains(searchText.lowercased())
        })
    }
}

extension MyShelfViewController: UITableViewDelegate {
    
}

extension MyShelfViewController: BookCardCellDelegate {
    func returnBook(book: Book?) {
        print("Returned")
    }
    
    func requestBook(book: Book?) {
        print("Requested")
    }
    
    func cancelReservation(book: Book?) {
        print("Canceled")
    }
}

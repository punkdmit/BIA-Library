//
//  BooksListViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 06.03.2023.
//

import UIKit

class BooksListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIAdaptivePresentationControllerDelegate, UISheetPresentationControllerDelegate, UISearchBarDelegate {
    
    let searchController = UISearchController()
    var viewModel : BooksViewModel?
    private var selectedCell: BookListCollectionViewCell?
    private var selectedCellText: String?
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var booksTableView: UITableView!
    
    let reuseIdentifer = "BookListTags"

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView() {
        navigationItem.hidesBackButton = true
        setUpNavBarItems()
        viewModel?.loadBookList()
        bindViewModel()
        setTableView()
        setUpCollectionView()
        setUpSearchController()
    }
    
    private func setUpSearchController() {
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setUpNavBarItems() {
        let label = UILabel()
        label.text = "Главная"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.sizeToFit()
        
        let item = UIBarButtonItem(customView: label)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 16 // Set the width of the spacer to create an indent
        
        navigationItem.leftBarButtonItems = [spacer, item]
        
        let button = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(tapSlidersButton))
        button.tintColor = BooksColor.textPrimary
        
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func tapSlidersButton() {
        let storyboard = UIStoryboard(name: "SliderViewControler", bundle: nil)
        let popUpviewController = storyboard.instantiateViewController(withIdentifier: "SliderViewControler")
        let nav = UINavigationController(rootViewController: popUpviewController)
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(nav, animated: true)
    }
    private func setTableView() {
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.register(UINib(nibName: "BooksTableViewCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        booksTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")

    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "BookListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = viewModel?.dataSource.value {
            return dataSource.count
        } else {
            return viewModel?.bookList.value?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel?.isSearching.value != false {
        case false:
           guard let cell = booksTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BooksTableViewCell else {
                return UITableViewCell()
            }
            guard let viewModel = viewModel else {
                return UITableViewCell()
            }
            if let dataSource = viewModel.bookList.value {
                let book = dataSource[indexPath.row]
                cell.viewModel = BookListCellViewModel(book: book)
                cell.bindViewModel()
            }
            return cell
            
        case true:
          guard let cell = booksTableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? SearchResultTableViewCell else {return UITableViewCell()}
            guard let bookList = viewModel?.dataSource.value else {
                return UITableViewCell()
            }
            let book = bookList[indexPath.row]
            cell.viewModel = BookListCellViewModel(book: book)
            cell.bindViewModel()
            return cell
        }
        
//        guard let cell = booksTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BooksTableViewCell else {
//            return UITableViewCell()
//        }
//        guard let viewModel = viewModel else {
//            return UITableViewCell()
//        }
//        if let dataSource = viewModel.dataSource.value {
//            let book = dataSource[indexPath.row]
//            cell.viewModel = BookListCellViewModel(book: book)
//        } else {
//            guard let bookList = viewModel.bookList.value else {
//                return UITableViewCell()
//            }
//            let book = bookList[indexPath.row]
//            cell.viewModel = BookListCellViewModel(book: book)
//        }
//        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {return}
        guard let vc = UIStoryboard.init(name: "BookDetailViewController", bundle: nil).instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController else {return}
        guard let bookId = viewModel.bookList.value?[indexPath.row].id else {return}
        vc.viewModel = BookDetailViewModel(bookId: bookId)
        vc.bindViewModel()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.bookListTags.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as? BookListCollectionViewCell else {return UICollectionViewCell()}
        
        let label = viewModel?.bookListTags[indexPath.row]
        cell.tagName?.text = label
        
        if selectedCellText == label {
            selectedCell = cell
            selectedCell?.set(isSelected: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BookListCollectionViewCell, selectedCell != cell else { return }
        
        selectedCell?.set(isSelected: false)
        cell.set(isSelected: true)
        selectedCell = cell
        selectedCellText = cell.tagName.text
        
    }
    
    func bindViewModel() {
        viewModel?.bookList.bind { [weak self] bookList in
            self?.booksTableView.reloadData()
        }
    }
}

extension BooksListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.isSearching.value = !(searchController.searchBar.text?.isEmpty ?? true)
        
        if searchController.searchBar.text != viewModel?.searchText.value {
            viewModel?.searchText.value = searchController.searchBar.text
            filterContentForSearchText(searchController.searchBar.text ?? "")
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            viewModel?.dataSource.value = nil
        } else {
            viewModel?.dataSource.value = viewModel?.bookList.value?.filter { (book: BookList) -> Bool in
                return book.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        booksTableView.reloadData()
    }
}

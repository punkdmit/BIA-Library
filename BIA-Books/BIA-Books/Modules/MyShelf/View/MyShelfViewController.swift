//
//  MyShelfViewController.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import UIKit

class MyShelfViewController: UIViewController, UISearchBarDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySegmentControlStack: UIStackView!
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    @IBOutlet weak var whenSearchingLabelStack: UIStackView!
    @IBOutlet weak var whenSearchingLabel: UILabel!
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        setSegment(index: sender.selectedSegmentIndex)
    }
            
    private let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: MyShelfViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        tableView.register(UINib(nibName: "RequestedBookCardCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "ResultViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        tableView.dataSource = self
        tableView.delegate = self
        
//        self.view.addSubview(searchController.searchBar)

        setupNavigationControllerTitle()
        setupSearchController()
        setupNavigationControllerSortImage()
        setSegment(index: 0)
    }
    
    func bindViewModel() {
        viewModel?.dataSource.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        viewModel?.reserveError.bind({ message in
            guard let message = message else { return }
            let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
    
    func setupNavigationControllerTitle() {
        let label = UILabel()
        label.text = "Моя полка"
        label.font = UIFont(name: "Inter-Regular_Bold", size: 32)
        label.sizeToFit()

        let item = UIBarButtonItem(customView: label)
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        navigationItem.leftBarButtonItems = [spacer, item]
    }
    
    func setupNavigationControllerSortImage() {
        let button = UIBarButtonItem(image: UIImage(named: "Slider"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = button
        navigationItem.rightBarButtonItem?.tintColor = BooksColor.textPrimary
    }
    
    func setupSearchController() {
//        self.view.addSubview(searchController.searchBar)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true

//        searchController.searchBar.frame = CGRect(x: 0, y: view.bounds.height - searchController.searchBar.bounds.height, width: view.bounds.width, height: searchController.searchBar.bounds.height)
//
//        if #available(iOS 11.0, *) {
//            searchController.searchBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//        } else {
//            searchController.searchBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
//        }
    }
    
    private func setSegment(index: Int) {
        switch index {
        case 0:
            viewModel?.getRequestedBooksList()
            whenSearchingLabel.text = "Запрошенные книги:"
        case 1:
            viewModel?.getRentedBooksList()
            whenSearchingLabel.text = "Арендованные книги:"
        case 2:
            viewModel?.getReturnedBooksList()
            whenSearchingLabel.text = "Прочитанные книги:"
        default:
            viewModel?.dataSource.value = []
        }
    }
}

extension MyShelfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellType: BookCardViewModel.CellType?
        
        switch(mySegmentControl.selectedSegmentIndex) {
            case 0:
                cellType = .requested
            case 1:
                cellType = .reading
            case 2:
                cellType = .returned
            default:
                cellType = nil
        }
        
        switch viewModel?.isSearching != false {
            case false:
                guard let cellType = cellType, let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookCardCell else { return UITableViewCell() }
                
                guard let dataSource = viewModel?.dataSource.value else { return UITableViewCell() }
                let book = dataSource[indexPath.row]
                cell.viewModel = BookCardViewModel(myShelf: book, cellType: cellType)
                cell.bindViewModel()
                cell.delegate = self
                return cell
            
            case true:
                guard let cellType = cellType, let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultViewCell else { return UITableViewCell() }
                
                guard let dataSource = viewModel?.dataSource.value else { return UITableViewCell() }
                let book = dataSource[indexPath.row]
                cell.viewModel = BookCardViewModel(myShelf: book, cellType: cellType)
                cell.bindViewModel()
                return cell
        }
    }
}

extension MyShelfViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.isSearching = !(searchController.searchBar.text?.isEmpty ?? true)
        
        if searchController.searchBar.text != viewModel?.searchText  {
            viewModel?.searchText = searchController.searchBar.text
            filterContentForSearchText(searchController.searchBar.text ?? "")
        }
        
        switch (viewModel?.isSearching != false) {
            case true:
                mySegmentControlStack.isHidden = true
                whenSearchingLabelStack.isHidden = false
            case false:
                mySegmentControlStack.isHidden = false
                whenSearchingLabelStack.isHidden = true
                viewModel?.dataSource.value = viewModel?.allBooksDataSource.value
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel?.dataSource.value = viewModel?.allBooksDataSource.value?.filter { (book: Book) -> Bool in
            return book.bookName.lowercased().contains(searchText.lowercased())
        }
    }
}

extension MyShelfViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        guard let vc = UIStoryboard.init(name: "BookDetailViewController", bundle: nil).instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController else { return }
        guard let bookId = viewModel.dataSource.value?[indexPath.row].bookId else { return }
        vc.viewModel = BookDetailViewModel(bookId: bookId)
        vc.bindViewModel()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyShelfViewController: BookCardCellDelegate {
    func returnBook(book: Book?) {
        viewModel?.cancelBookRent(bookId: book?.bookId ?? "")
    }
    
    func reserveBook(book: Book?) {
        viewModel?.reserve(bookId: book?.bookId ?? "")
    }
    
    func cancelReservation(book: Book?) {
        viewModel?.cancelBookRequest(bookId: book?.bookId ?? "")
    }
}

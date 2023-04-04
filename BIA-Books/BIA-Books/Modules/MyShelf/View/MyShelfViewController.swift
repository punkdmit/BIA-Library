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
    
//    private enum SegmentedControlItems: String, CaseIterable {
//        case case1 = "Case1"
//        case case2 = "Case2"
//        case case3 = "Case3"
//    }
//    private let cases = [SegmentedControlItems.case1, SegmentedControlItems.case2, SegmentedControlItems.case3]

    
    
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel?.dataSource = viewModel?.booksPreset.filter{ $0.bookStatus == .requested } ?? []
        } else if sender.selectedSegmentIndex == 1 {
            viewModel?.dataSource = viewModel?.booksPreset.filter{ $0.bookStatus == .reading } ?? []
        } else if sender.selectedSegmentIndex == 2 {
            viewModel?.dataSource = viewModel?.booksPreset.filter{ $0.bookStatus == .read } ?? []
        }
        tableView.reloadData()
    }
    
    private let searchController = UISearchController(searchResultsController: nil)

    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        tableView.register(UINib(nibName: "RequestedBookCardCell", bundle: nil), forCellReuseIdentifier: "RequestedBookCardCell")
        tableView.register(UINib(nibName: "ResultViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavigationControllerTitle()
        setupSearchController()
        setupNavigationControllerSortImage()
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
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
}

extension MyShelfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestedBookCardCell", for: indexPath) as? RequestedBookCardCell else { return UITableViewCell() }
//        let cellViewModel = viewModel?.cellViewModel(indexPath: indexPath)
//        cell.viewModel = cellViewModel
//        return cell
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
        
        guard let cellType = cellType, let cell = tableView.dequeueReusableCell(withIdentifier: "RequestedBookCardCell", for: indexPath) as? RequestedBookCardCell else { return UITableViewCell() }
        let cellViewModel = viewModel?.cellViewModel(indexPath: indexPath, type: cellType)
        cell.viewModel = cellViewModel
        return cell
    }
}

// МЕТОД ДЛЯ СЕРЧ КОНТРЛОЛЛЕРА КОТОРЫЙ СМОТРИТ НА ВВЕДЕННЫЙ ТЕКСТ В СТРОКУ
extension MyShelfViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
    }
}

extension MyShelfViewController: UITableViewDelegate {
    
}

extension MyShelfViewController: BookCardCellDelegate {
    func cancelReservation(book: Book?) {
        print("Salam")
    }
}

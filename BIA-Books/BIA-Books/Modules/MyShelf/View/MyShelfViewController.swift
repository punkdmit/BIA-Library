//
//  MyShelfViewController.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import UIKit

class MyShelfViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
        } else if sender.selectedSegmentIndex == 1 {
            
        } else if sender.selectedSegmentIndex == 2 {
            
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let t = UISegmentedControl()
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        tableView.register(UINib(nibName: "BookCardCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
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
        return viewModel?.myShelfs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestedBookCardCell", for: indexPath) as? RequestedBookCardCell else { return UITableViewCell() }
        let cellViewModel = viewModel?.cellViewModel(indexPath: indexPath)
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

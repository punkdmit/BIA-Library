//
//  MyShelfViewController.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import UIKit

class MyShelfViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        tableView.register(UINib(nibName: "BookCardCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavigationControllerTitle()
        setupSearchController()
    }
    
    func setupNavigationControllerTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Моя полка"
    }
    
    func setupSearchController() {
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookCardCell else { return UITableViewCell() }
        let viewModel = viewModel
        let cellViewModel = viewModel?.cellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

extension MyShelfViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
        let cell = searchController.searchResultsController as? ResultTableViewCell
    }
}

extension MyShelfViewController: UITableViewDelegate {
    
}

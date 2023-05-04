//
//  BooksListViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 06.03.2023.
//

import UIKit

class BooksListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        viewModel?.loadBookList()
        bindViewModel()
    }
    
    private func setView() {
        navigationItem.hidesBackButton = true
        viewModel = BooksViewModel()
        searchBar.placeholder = "Поиск"
        setTableView()
        setUpCollectionView()
    }
    
    private func setTableView() {
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.register(UINib(nibName: "BooksTableViewCell", bundle: nil), forCellReuseIdentifier: "bookCell")
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "BookListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.bookList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = booksTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BooksTableViewCell else { return UITableViewCell() }
        guard let viewModel = viewModel else { return UITableViewCell() }
        guard let bookList = viewModel.bookList.value else { return UITableViewCell() }
        
        let book = bookList[indexPath.row]
        cell.viewModel = BookListCellViewModel(book : book)
        cell.noSelectionStyle()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "BookDetailViewController", bundle: nil).instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController else {return}
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

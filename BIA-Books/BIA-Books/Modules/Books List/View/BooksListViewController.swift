//
//  BooksListViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 06.03.2023.
//

import UIKit

class BooksListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellHeight : CGFloat = 131
    let cellSpacingHeight : CGFloat = 16
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var booksTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    
    private func setView() {
        searchBar.placeholder = "Поиск"
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.register(UINib(nibName: "BooksTableViewCell", bundle: nil), forCellReuseIdentifier: "bookCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = booksTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BooksTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

//
//  MyShelfViewController.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import UIKit

class MyShelfViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BookCardCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension MyShelfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.myShelfs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookCardCell else { return UITableViewCell() }
        let viewModel = viewModel
        let cellViewModel = viewModel?.cellViewModel(indexPath: indexPath)
        
        cell.viewModel = cellViewModel
        
        
//        let a = viewModel?.myShelfs?[indexPath.row]
//        cell.i = viewModel?.myShelfs?[indexPath.row]
        
//        cell.bookNameLabel.text = a.bookName
//        cell.authorLabel.text = a.authorName
//        cell.bookImage.image = a.bookImage
        
        cell.setup()
        return cell
    }
}

extension MyShelfViewController: UITableViewDelegate {
    
}

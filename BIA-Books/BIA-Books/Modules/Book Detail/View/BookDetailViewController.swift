//
//  BookDetailViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 17.03.2023.
//

import UIKit
import ReadMoreTextView


class BookDetailViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel : BookDetailViewModel?
    
    let reuseIdentifer = "Cell"
    
    @IBOutlet weak var detailCardView: UIView!
    @IBOutlet weak var bookRequestButton: UIButton!
    
    @IBOutlet weak var descriptionTextView: ReadMoreTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    private func setView() {
        viewModel = BookDetailViewModel()
        setUpCollectionView()
        customBackButton()
        detailCardView.aplyShadow(cornerRadius: 12)
        bookRequestButton.roundedCornerButton(radius: 6)
        setTextView(textView: descriptionTextView)
    }
    
    private func customBackButton() {
        let backBTN = UIBarButtonItem(image: UIImage(named: "backButton"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        backBTN.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setTextView(textView : ReadMoreTextView) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: BooksColor.brandSecondary,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textView.shouldTrim = true
        textView.maximumNumberOfLines = 4
        textView.attributedReadMoreText = NSAttributedString(string: "... Подробнее ⌄" , attributes: attributes)
        textView.attributedReadLessText = NSAttributedString(string: " Подробнее", attributes: attributes)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as? TagsCollectionViewCell else {return UICollectionViewCell()}
        let label = viewModel?.labels[indexPath.row]
        cell.label?.text = label
        
        return cell
    }
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func requsetBok(_ sender: Any) {
        let alertController = UIAlertController(title: "Запрос книги", message: "Хотите запросить книгу?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Да", style: .default) { (action:UIAlertAction!) in
            // Действия, которые нужно выполнить при выборе "Да"
        }

        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { (action:UIAlertAction!) in
            // Действия, которые нужно выполнить при выборе "Отменить"
        }

        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion:nil)
    }
}

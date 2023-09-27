//
//  BookDetailViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 17.03.2023.
//

import UIKit
import ReadMoreTextView


class BookDetailViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var bookDescription: ReadMoreTextView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var pages: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var bookDetailId : String?
    var viewModel : BookDetailViewModel?
    private var bookList : BooksListViewController!
    let reuseIdentifer = "Cell"
    
    @IBOutlet weak var detailCardView: UIView!
    @IBOutlet weak var bookRequestButton: UIButton!
    
    var numberOfRows: Int?
    
    
    @IBOutlet weak var descriptionTextView: ReadMoreTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    private func setView() {
        setUpCollectionView()
        customBackButton()
        detailCardView.aplyShadow(cornerRadius: 12)
        bookRequestButton.roundedCornerButton(radius: 6)
        bookCover.roundedCornerButton(radius: 6)
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
        return viewModel?.pickedBook.value?.tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as? TagsCollectionViewCell else {return UICollectionViewCell()}
        let label = viewModel?.pickedBook.value?.tags?[indexPath.row]
        cell.label?.text = label
        
        return cell
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
     func bindViewModel() {
        viewModel?.pickedBook.bind({ [weak self] bookInfo in
            self?.bookName.text = bookInfo?.name
            self?.author.text = bookInfo?.author
            self?.bookDescription.text = bookInfo?.description
            self?.pages.text = bookInfo?.pages
            self?.year.text = bookInfo?.year
            self?.rate.text = bookInfo?.rate
            self?.language.text = bookInfo?.language
            self?.bookCover.image = self?.decodeImage(imageData: bookInfo?.image ?? "")
            self?.collectionView.reloadData()
        })
         
        viewModel?.reservationError.bind { message in
            guard let message = message else { return }
            
            let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let keyWindow = windowScene.windows.filter({ $0.isKeyWindow }).first {
                keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func decodeImage(imageData: String) -> UIImage? {
        
        guard let dataDecoded = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) else { return nil }
        
        return UIImage(data: dataDecoded)
    }
    
    @IBAction func requsetBok(_ sender: Any) {
        let alertController = UIAlertController(title: "Запрос книги", message: "Хотите запросить книгу?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Да", style: .default) { (action:UIAlertAction!) in
            self.viewModel?.reserveBook()
        }

        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { (action:UIAlertAction!) in
            
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion:nil)
    }
}

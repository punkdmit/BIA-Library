//
//  BookCardCell.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 10.03.2023.
//

import UIKit

protocol BookCardCellDelegate: AnyObject {
    func cancelReservation(book: Book?)
    func returnBook(book: Book?)
    func requestBook(book: Book?)
}

class RequestedBookCardCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var cancelRequestStack: UIStackView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var buttonImage: UIImageView!
    
    @IBOutlet weak var view: UIView!
    
    weak var delegate: BookCardCellDelegate?
    
    var viewModel: CardViewModel? {
        willSet(viewModel) {
            bookImage.image = viewModel?.bookImage
            bookNameLabel.text = viewModel?.bookName
            authorLabel.text = viewModel?.authorName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setupButtonView()
    }
    
    func setup() {
        bookImage.layer.cornerRadius = 8
        bookImage.layer.cornerCurve = .continuous
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 12
            
        addCancelRequestGestureRecognizer()
    }
    
    func setupButtonView() {
        switch viewModel?.cellType {
            case .requested:
                buttonLabel.text = "Отменить запрос"
                buttonLabel.tintColor = BooksColor.redText
                buttonImage.image = UIImage(named: "Delite")
            case .reading:
                buttonLabel.text = "Сдать"
                buttonLabel.tintColor = BooksColor.activeColor
                buttonImage.image = UIImage(named: "Add new")
            case .read:
                buttonLabel.text = "Запросить"
                buttonLabel.tintColor = BooksColor.activeColor
                buttonImage.image = UIImage(named: "Add new")
            default:
                buttonLabel.text = ""
                buttonLabel.tintColor = .white
                buttonImage.image = UIImage(named: "")
        }
    }
    
    private func addCancelRequestGestureRecognizer()  {
        let cancelRequestStack = UITapGestureRecognizer(target: self, action: #selector(self.cancelReservationPressed(tapGesture:)))
        self.cancelRequestStack.addGestureRecognizer(cancelRequestStack)
    }
    
    @objc func cancelReservationPressed(tapGesture: UITapGestureRecognizer) {
        let alert = UIAlertController(title: viewModel?.bookName, message: "Хотите отменить запрос?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.delegate?.cancelReservation(book: self?.viewModel?.book)
        })
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

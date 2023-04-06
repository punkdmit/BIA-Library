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
    
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var buttonImage: UIImageView!
    
    @IBOutlet weak var view: UIView!
    
    weak var delegate: BookCardCellDelegate?
    
    var viewModel: CardViewModel?
    /*
    {
        didSet(viewModel) {
            bookImage.image = viewModel?.bookImage
            bookNameLabel.text = viewModel?.bookName
            authorLabel.text = viewModel?.authorName
            setupButtonView()
        }
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    /*
    override func prepareForReuse() {
        super.prepareForReuse()
        setup()
    }
    */
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        bookImage.image = viewModel.bookImage
        bookNameLabel.text = viewModel.bookName
        authorLabel.text = viewModel.authorName
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
        //setupButtonView()
    }
    
    func setupButtonView() {
        guard let viewModel = viewModel else { return }
        
        switch viewModel.cellType {
            case .requested:
                buttonLabel.text = "Отменить запрос"
                buttonLabel.tintColor = BooksColor.redText
                buttonImage.image = UIImage(named: "Delete")
            
            case .reading:
                buttonLabel.text = "Сдать"
                buttonLabel.tintColor = BooksColor.activeColor
                buttonImage.image = UIImage(named: "Add new")
            
            case .read:
                buttonLabel.text = "Запросить"
                buttonLabel.tintColor = BooksColor.activeColor
                buttonImage.image = UIImage(named: "Add new")
        }
    }
    
    private func addCancelRequestGestureRecognizer()  {
        let cancelRequestStack = UITapGestureRecognizer(target: self, action: #selector(self.cancelReservationPressed(tapGesture:)))
        self.buttonStack.addGestureRecognizer(cancelRequestStack)
    }
    
    @objc func cancelReservationPressed(tapGesture: UITapGestureRecognizer) {
        guard let viewModel = viewModel else { return }
    
        switch viewModel.cellType {
        case .requested:
            let alert = UIAlertController(title: viewModel.bookName, message: "Хотите отменить запрос?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
                self?.delegate?.cancelReservation(book: self?.viewModel?.book)
            })
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
//            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        case .reading:
            let alert = UIAlertController(title: viewModel.bookName, message: "Хотите сдать книгу?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
                self?.delegate?.returnBook(book: self?.viewModel?.book)
            })
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
//            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        case .read:
            let alert = UIAlertController(title: viewModel.bookName, message: "Хотите запросить книгу?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
                self?.delegate?.requestBook(book: self?.viewModel?.book)
            })
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
//            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}


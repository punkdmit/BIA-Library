//
//  SliderViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 09.05.2023.
//

import UIKit

class SliderViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        saveButton.roundedCornerButton(radius: 6)
    }
    
    private func setUpNavBar() {
        let label = UILabel()
        label.text = "Сортировка"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.sizeToFit()

        let item = UIBarButtonItem(customView: label)

        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 16 // Set the width of the spacer to create an indent

        let imageView = UIImageView(image: UIImage(systemName: "arrow.up.arrow.down"))
        imageView.tintColor = BooksColor.textPrimary
        imageView.contentMode = .scaleAspectFit
        let imageButton = UIBarButtonItem(customView: imageView)

        navigationItem.leftBarButtonItems = [spacer, item, imageButton]
//        let backBTN = UIBarButtonItem(title: "Отменить",
//                                      style: .plain,
//                                      target: navigationController,
//                                      action: #selector(backButtonTapped))
//        navigationItem.rightBarButtonItem = backBTN
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
}

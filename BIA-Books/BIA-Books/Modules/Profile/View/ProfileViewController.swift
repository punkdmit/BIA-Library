//
//  ProfileViewController.swift
//  DiplomaLibraryOrig
//
//  Created by Dmitry Apenko on 20.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
//    var viewModel: ViewModel?
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var aboutAppLabel: UILabel!
    @IBOutlet weak var aboutAppArrowImage: UIImageView!
    @IBOutlet weak var faqLabel: UILabel!
    @IBOutlet weak var faqArrowImage: UIImageView!
    @IBOutlet weak var exitLabel: UILabel!
    
    @IBOutlet weak var firstCornerButtonsStack: UIStackView!
    @IBOutlet weak var SecondCornerButtonStack: UIStackView!

    @IBAction func aboutAppButtonPressed(_ sender: Any) {
        
    }
    
    private var viewModel: ProfileViewModel? {
        willSet(viewModel) {
            fullNameLabel.text = viewModel?.fullName
            mailLabel.text = viewModel?.mail
            photoImage.image = viewModel?.profilePhoto
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel(profile: Profile(profilePhoto: UIImage(named: "1"), name: "Dmitry", secondName: "Apenko", mail: "dima.gg2001@mail.ru"))
        setView()
    }
    
    private func setView() {
        setupUserPhoto(image: photoImage)
        setupFullNameLabel(label: fullNameLabel)
        setupMailLabel(label: mailLabel)
        setupButtonsStacks(stacks: [firstCornerButtonsStack, SecondCornerButtonStack])
        setupAboutAppButton(label: aboutAppLabel, image: aboutAppArrowImage)
        setupFaqButton(label: faqLabel, image: faqArrowImage)
        setupExitButton(label: exitLabel)
    }
    
    private func setupUserPhoto(image photoImage: UIImageView) {
        photoImage.layer.cornerRadius = 16
    }
    
    private func setupFullNameLabel(label fullNameLabel: UILabel) {
        fullNameLabel.textColor = BooksColor.textPrimary
    }
    
    private func setupMailLabel(label mailLabel: UILabel) {
        mailLabel.textColor = BooksColor.textSecondary
    }
    
    private func setupButtonsStacks(stacks buttonsStacks: [UIStackView]) {
        for stack in buttonsStacks {
            stack.layer.shadowOffset = CGSize(width: 0, height: 4)
            stack.layer.shadowColor = UIColor.black.cgColor
            stack.layer.shadowOpacity = 0.12
            stack.layer.shadowRadius = 4
            stack.layer.cornerRadius = 12
        }
    }
    
    private func setupAboutAppButton(label aboutAppLabel: UILabel, image aboutAppArrowImage: UIImageView) {
        aboutAppLabel.text = "О приложении"
        aboutAppLabel.textColor = BooksColor.textPrimary
        aboutAppArrowImage.image = UIImage(named: "arrow")
    }
    
    private func setupFaqButton(label faqLabel: UILabel, image faqArrowImage: UIImageView) {
        faqLabel.text = "FAQ"
        faqLabel.textColor = BooksColor.textPrimary
        faqArrowImage.image = UIImage(named: "arrow")
    }
    
    private func setupExitButton(label exitLabel: UILabel) {
        exitLabel.text = "Выйти"
        exitLabel.textColor = BooksColor.RedText
    }
}


//
//  ProfileViewController.swift
//  DiplomaLibraryOrig
//
//  Created by Dmitry Apenko on 20.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
//    @IBOutlet weak var aboutAppLabel: UILabel!
//    @IBOutlet weak var aboutAppArrowImage: UIImageView!
//    @IBOutlet weak var faqLabel: UILabel!
//    @IBOutlet weak var faqArrowImage: UIImageView!
//    @IBOutlet weak var exitLabel: UILabel!
    
    @IBOutlet weak var AboutAndFaqButtonsCornerStack: UIStackView!
    @IBOutlet weak var AboutButtonStack: UIStackView!
    @IBOutlet weak var FaqButtonStack: UIStackView!

    @IBOutlet weak var ExitButtonCornerStack: UIStackView!
    
    var viewModel: ProfileViewModel? {
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
        addExitGestureRecognizer()
        addAboutGestureRecognizer()
        addFaqGestureRecognizer()
    }
    
    func addAboutGestureRecognizer() {
        let aboutTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.aboutPressed(tapGesture:)))
        AboutButtonStack.addGestureRecognizer(aboutTapRecognizer)
    }
    
    @objc func aboutPressed(tapGesture: UITapGestureRecognizer) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addFaqGestureRecognizer() {
            let faqTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.faqPressed(tapGesture:)))
            FaqButtonStack.addGestureRecognizer(faqTapRecognizer)
        }
        
    @objc func faqPressed(tapGesture: UITapGestureRecognizer) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addExitGestureRecognizer() {
        let exitTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.exitPressed(tapGesture:)))
        ExitButtonCornerStack.addGestureRecognizer(exitTapRecognizer)
    }
    
    @objc func exitPressed(tapGesture: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Вы уверены, что хотите выйти из учетной записи?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func setView() {
        setupUserPhoto(image: photoImage)
        setupButtonsStacks(stacks: [AboutAndFaqButtonsCornerStack, ExitButtonCornerStack])
    }
    
    private func setupUserPhoto(image photoImage: UIImageView) {
        photoImage.layer.cornerRadius = 16
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
}

extension UIAlertAction {
    static var propertyNames: [String] {
        var outCount: UInt32 = 0
        guard let ivars = class_copyIvarList(self, &outCount) else {
            return []
        }
        var result = [String]()
        let count = Int(outCount)
        for i in 0..<count {
            let pro: Ivar = ivars[i]
            guard let ivarName = ivar_getName(pro) else {
                continue
            }
            guard let name = String(utf8String: ivarName) else {
                continue
            }
            result.append(name)
        }
        return result
    }
}

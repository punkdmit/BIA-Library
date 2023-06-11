//
//  ViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 16.02.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    var viewModel = AthorizationViewModel()
    
    @IBOutlet weak var loginTextField: BiaBooksTextField!
    @IBOutlet weak var passwordTextField: BiaBooksTextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logInStatus: UILabel!
    
    private lazy var eyeButton: UIButton =  {
        let eyeButton = UIButton()
        eyeButton.tintColor = BooksColor.textSecondary
        eyeButton.addTarget(self, action: #selector(pressedEyeButton(sender:)), for: .touchUpInside)
        return eyeButton
    }()
    
    @IBAction func loginChanged(_ sender: Any) {
        updateLogInButton(isEmpty: loginTextField.text == "")
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        viewModel.userLogInButtonPressed(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
        if viewModel.loginSuccess.value == false {
            logInButton.isEnabled = false
            logInButton.backgroundColor = BooksColor.entryButton
            logInButton.titleLabel?.textColor = BooksColor.textSecondary
        }
        resetForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindViewModel()
        viewModel.checkAccessToken()
    }
    
    func resetForm() {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    func updateLogInButton(isEmpty: Bool) {
        if isEmpty {
            logInButton.backgroundColor = BooksColor.entryButton
            logInButton.titleLabel?.textColor = BooksColor.textSecondary
            logInButton.isEnabled = false
        } else {
            logInButton.backgroundColor = BooksColor.brandPrimary
            logInButton.titleLabel?.textColor = BooksColor.brandTertiary
            logInButton.isEnabled = true
        }
    }
    
    @objc func pressedEyeButton(sender : AnyObject) {
        set(isSecureTextEntry: !passwordTextField.isSecureTextEntry)
    }
    
    func setupPasswordTextField() {
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        passwordTextField.label.text = "Пароль"
    }
    
    func setupLoginTextField() {
        loginTextField.label.text = "Логин"
    }
    
    private func set(isSecureTextEntry: Bool) {
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        eyeButton.setImage(image: (isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")))
    }
    
    private func setUpView() {
        logInButton.isEnabled = false
        logInButton.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
        setupLoginTextField()
        setupPasswordTextField()
        set(isSecureTextEntry: true)
    }
    
    func bindViewModel() {
        viewModel.statusText.bind({(statusText) in
            DispatchQueue.main.async {
                self.logInStatus.text = statusText
            }
        })
        viewModel.loginSuccess.bind { value in
            if value {
                let vc = TabBarController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


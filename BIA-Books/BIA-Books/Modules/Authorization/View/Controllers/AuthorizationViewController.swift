//
//  ViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        viewModel.userLogInButtonPressed(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindViewModel()
    }
    
    func updateLogInButton(button : UIButton) -> UIButton {
        if loginTextField.text != "" && passwordTextField.text != "" {
            button.backgroundColor = #colorLiteral(red: 0.2605186105, green: 0.2605186105, blue: 0.2605186105, alpha: 1)
            button.titleLabel?.textColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        }
        return button
    }
    //some comment for check
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
    }
}


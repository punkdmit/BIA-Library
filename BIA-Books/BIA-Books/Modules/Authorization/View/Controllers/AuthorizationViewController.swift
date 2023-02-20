//
//  ViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var isSecureField = true
    var viewModel = AthorizationViewModel()
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logInStatus: UILabel!
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        viewModel.userLogInButtonPressed(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        bindViewModel()
        
    }
    
    func bindViewModel() {
        viewModel.statusText.bind({(statusText) in
            DispatchQueue.main.async {
                self.logInStatus.text = statusText
            }
        })
    }
}
 

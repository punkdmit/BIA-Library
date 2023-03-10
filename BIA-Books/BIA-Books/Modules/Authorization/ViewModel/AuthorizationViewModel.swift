//
//  AuthorizationViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 16.02.2023.
//

import Foundation

class AthorizationViewModel {
    var statusText = Dynamic("")
    
    func userLogInButtonPressed(login: String, password: String) -> Bool {
        if login != User.users[0].login ||  password != User.users[0].password {
            statusText.value = "Вы ввели некорректный логин или пароль"
            return false
        } else {
            statusText.value = "Вы успешно авторизовались"
            return true
        }
    }
}

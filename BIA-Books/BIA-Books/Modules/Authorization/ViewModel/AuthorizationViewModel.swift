//
//  AuthorizationViewModel.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 16.02.2023.
//

import Foundation

class AthorizationViewModel {
    var loginSuccess = Dynamic(false)
    var statusText = Dynamic("")
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
    
    func checkAccessToken() {
        loginSuccess.value = UserDefaults.standard.string(forKey: "accessToken") != nil
    }
    
    func userLogInButtonPressed(login: String, password: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .withoutEscapingSlashes
        guard let json = try? encoder.encode(["email": login, "password": password]) else {return}
        
        let jsonString = String(data: json, encoding: .utf8)
        
        fetcher.login(params: [:], body: jsonString) { [weak self] response in
            if let response = response {
                UserDefaults.standard.set(response.accessToken, forKey: "accessToken")
                self?.loginSuccess.value = true
            } else {
                self?.loginSuccess.value = false
                self?.statusText.value = "Вы ввели некорректный логин или пароль"
            }
        }
    }
}

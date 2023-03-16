//
//  User .swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 16.02.2023.
//

import Foundation

struct UsersList {
    var users : [User]
}

struct User {
    let login : String?
    let password : String?
}

extension User {
    static var users = [
        User(login: "aa", password: "111"),
        User(login: "punk", password: "biatop")
    ]
}


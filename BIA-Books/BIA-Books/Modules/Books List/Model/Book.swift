//
//  Book.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 06.03.2023.
//

import Foundation

struct Book {
    var id : UUID?
    var status : Bool
    var name : String?
    var author : String?
    var language : String?
    var image : String?
    var ratings : String?
    var stars : Int?
    var available : Bool?
}

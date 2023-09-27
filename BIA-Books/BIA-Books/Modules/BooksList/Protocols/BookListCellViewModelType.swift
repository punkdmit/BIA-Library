//
//  BookListCellViewModelType.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 04.05.2023.
//

import Foundation

protocol BookListCellViewModelType  {
    var _id : String {get}
    var name : String {get}
    var author : String {get}
    var language : String {get}
    var  description : String {get}
    var status : String {get}
    var image : String {get}
}

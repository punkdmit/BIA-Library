//
//  RequestProtocol.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 24.04.2023.
//
import Foundation

protocol RequestProtocol {
    var path : String {get}
    
    var headers : [String : String] {get}
    var params : [String : Any] {get}
    
    var urlParams : [String : String?] {get}
    
    var addAuthToken : Bool {get}
    
    var requestType : RequestType {get}
}

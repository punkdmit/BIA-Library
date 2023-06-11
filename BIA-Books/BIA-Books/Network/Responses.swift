import Foundation

public struct BookList: Codable {
    let id: String?
    let name: String?
    let author: String?
    let language: String?
    let description: String?
    let image: String?
    let status: Bool?
    let rate: String?
    let tags : [String]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case author = "author"
        case language = "language"
        case description = "description"
        case status = "status"
        case image = "image"
        case rate = "rate"
        case tags = "tags"
    }
}

public struct BookInfo: Codable {
    let _id : String?
    let name : String?
    let author : String?
    let language :String?
    let description : String?
    let status : Bool?
    let image : String?
    let year : String?
    let pages : String?
    let rate : String?
    let tags : [String]?
    //    let expirationDate : Date?
}

public struct UserInfo: Codable {
    let id: String?
    let firstName: String?
    let lastName: String?
    let email: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
    }
}



public struct Login: Codable {
    let accessToken: String
}

public struct Fault: Codable {
    let error: String
}


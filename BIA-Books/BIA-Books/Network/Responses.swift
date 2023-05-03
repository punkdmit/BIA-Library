import Foundation

public struct BookList : Codable {
    let _id : String?
    let name : String?
    let author : String?
    let language : String?
    let description : String?
    let status : String?
    let image : String?
}

public struct BookInfo : Codable {
    let _id : String?
    let name : String?
    let author : String?
    let language :String?
    let description : String?
    let status : String?
    let image : String?
    let isReserved : Bool?
    let expirationDate : Date?
//    let year : String?
//    let pages : String?
//    let rate : String?
//    let tags : [String]?
}

public struct Login: Codable {
    let accessToken: String
}

public struct Fault: Decodable {
    let code: String
    let description: String
    let message: String?
    
    private enum CodingKeys: String, CodingKey {
        case code = "NS2:code"
        case description = "NS3:description"
        case message = "NS4:message"
    }
}

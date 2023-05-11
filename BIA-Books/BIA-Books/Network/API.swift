enum Operation: String {
    case getNearbyVehicles = "getNearbyVehicles"
    case getVehicleData = "getVehicleData"
    case ping = ""
    case login = "auth"
    case bookList = "books"
    case requestedBookList = "requestedBooks"
    case rentedBookList = "rentedBooks"
    case cancelBookRequest = "cancelRequest"
    case cancelBookRent = "cancelRent"
    case reserveBook = "reserve"
    case bookInfo = "books/details"
}

struct API {
    static let scheme = "http"
    static let host = "localhost"
    static let port = 3600
    static let path = "/"
}

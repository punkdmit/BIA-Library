enum Operation: String {
    case ping = ""
    case login = "auth"
    case bookList = "books"
    case requestedBookList = "requestedBooks"
    case rentedBookList = "rentedBooks"
    case returnedBookList = "returnedBooks"
    case cancelBookRequest = "cancelRequest"
    case cancelBookRent = "cancelRent"
    case reserveBook = "reserve"
    case bookInfo = "books/details"
    case userInfo = "userInfo"
}

struct API {
    static let scheme = "http"
    static let host = "localhost"
    static let port = 3600
    static let path = "/"
}

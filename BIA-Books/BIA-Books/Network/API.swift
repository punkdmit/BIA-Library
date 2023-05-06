

enum Operation: String {
    case getNearbyVehicles = "getNearbyVehicles"
    case getVehicleData = "getVehicleData"
    case ping = ""
    case login = "auth"
    case bookList = "books"
    case bookInfo = "books/details"
}

struct API {
    static let scheme = "http"
    static let host = "localhost"
    static let port = 3600
    static let path = "/"
}

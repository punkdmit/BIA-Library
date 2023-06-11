

import Foundation

enum fetcherErrors: Error {
    case busError(description: String)
}

protocol DataFetcher {
    
    func getBookList(params : [String : String], response : @escaping (([BookList?]) -> Void))
    func getBookInfo(params: [String: String], response : @escaping (BookInfo?) -> Void)
    
    func login(params: [String: String], body: String?, response: @escaping (Login?) -> Void)
    
    func getRequestedBooksList(response: @escaping (([BookList?]) -> Void))
    func getRentedBooksList(response: @escaping (([BookList?]) -> Void))
    func cancelBookRequest(params : [String : String], response: @escaping ((Int) -> Void))
    func cancelBookRent(params : [String : String], response: @escaping ((Int) -> Void))
    func reserve(params: [String : String], response: @escaping ((Int, String?) -> Void))
    func getUserInfo(response : @escaping (UserInfo?) -> Void)

}

struct NetworkDataFetcher: DataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }

    func login(params: [String : String], body: String?, response: @escaping (Login?) -> Void) {
        networking.request(path: API.path, method: .post, operation: .login, headers: [:], params: params, body: body) { (data, statusCode, error) in
            if error != nil {
                //showMessageBox(title: "Ошибка сети", message: error.localizedDescription)
                response(nil)
            }
            
            guard let JSONData = data else { response(nil); return }
                        
            //let fault = self.decodeJSON(type: [Fault].self, from: JSONData)
            let decoded = self.decodeJSON(type: Login.self, from: JSONData)
            
            //self.handleFault(data: fault)
            
            response(decoded)
        }
    }
    func getBookList(params: [String : String], response: @escaping (([BookList?]) -> Void)) {
        guard let bearerToken =  UserDefaults.standard.string(forKey: "accessToken") else { return }
        networking.request(path: API.path, method: .get, operation: .bookList, headers: ["Authorization" : "Bearer " + bearerToken], params: [:] , body: nil) { data, statusCode, error in
            if error != nil {
                response([nil])
            }
            guard let JSONData = data else { response([nil]); return }
            
            guard  let decoded = self.decodeJSON(type: [BookList].self, from: JSONData) else { return }
            
            response(decoded)
        }
    }
    
    func getBookInfo(params: [String : String], response: @escaping (BookInfo?) -> Void) {
        guard let bearerToken =  UserDefaults.standard.string(forKey: "accessToken") else { print("Error: bearerToken is nil")
            return}
        
        networking.request(path: API.path, method: .get, operation: .bookInfo, headers: ["Authorization" : "Bearer " + bearerToken], params: params, body: nil) { data, statusCode, error in
            if error != nil {
                print("Error in networking request: \(error!)")
                response(nil)
            }
            guard let JSONData = data else {response(nil); return}
            
            guard let decoded = self.decodeJSON(type: BookInfo.self, from: JSONData) else {return }
            
            response(decoded)
        }
    }
    
    func getRequestedBooksList(response: @escaping (([BookList?]) -> Void)) {
        guard let bearerToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        networking.request(path: API.path, method: .get, operation: .requestedBookList, headers: ["Authorization" : "Bearer " + bearerToken], params: [:] , body: nil) { data, statusCode, error in
            if error != nil {
                response([nil])
            }
            guard let JSONData = data else { response([nil]); return }
            guard let decoded = self.decodeJSON(type: [BookList].self, from: JSONData) else { return }
            response(decoded)
        }
    }
    
    func getRentedBooksList(response: @escaping (([BookList?]) -> Void)) {
        guard let bearerToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        networking.request(path: API.path, method: .get, operation: .rentedBookList, headers: ["Authorization" : "Bearer " + bearerToken], params: [:] , body: nil) { data, statusCode, error in
            if error != nil {
                response([nil])
            }
            guard let JSONData = data else { response([nil]); return }
            guard let decoded = self.decodeJSON(type: [BookList].self, from: JSONData) else { return }
            response(decoded)
        }
    }
    
    func getReturnedBooksList(response: @escaping (([BookList?]) -> Void)) {
        guard let bearerToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        networking.request(path: API.path, method: .get, operation: .returnedBookList, headers: ["Authorization" : "Bearer " + bearerToken], params: [:] , body: nil) { data, statusCode, error in
            if error != nil {
                response([nil])
            }
            guard let JSONData = data else { response([nil]); return }
            guard let decoded = self.decodeJSON(type: [BookList].self, from: JSONData) else { return }
            response(decoded)
        }
    }
    
    
    func cancelBookRequest(params: [String : String], response: @escaping ((Int) -> Void)) {
        guard let bearerToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        networking.request(path: API.path, method: .post, operation: .cancelBookRequest, headers: ["Authorization" : "Bearer " + bearerToken], params: params , body: nil) { data, statusCode, error in
            if error == nil {
                response(statusCode)
            } else {
                response(500)
            }
        }
    }
    
    func cancelBookRent(params: [String : String], response: @escaping ((Int) -> Void)) {
        guard let bearerToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        networking.request(path: API.path, method: .post, operation: .cancelBookRent, headers: ["Authorization" : "Bearer " + bearerToken], params: params , body: nil) { data, statusCode, error in
            if error == nil {
                response(statusCode)
            } else {
                response(500)
            }
        }
    }
    
    func reserve(params: [String : String], response: @escaping ((Int, String?) -> Void)) {
        guard let bearerToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        networking.request(path: API.path, method: .post, operation: .reserveBook, headers: ["Authorization" : "Bearer " + bearerToken], params: params , body: nil) { data, statusCode, error in
            if error == nil {
                
                var message: String?
                
                if statusCode != 200 {
                    guard let JSONData = data,
                    let decoded = self.decodeJSON(type: Fault.self, from: JSONData) else { response(500, "Не удалось разобрать ответ сервера"); return }
                    message = decoded.error
                }
                
                response(statusCode, message)
                
            } else {
                response(500, "Внутрення ошибка")
            }
        }
    }
    
    func getUserInfo(response: @escaping (UserInfo?) -> Void) {
        guard let bearerToken =  UserDefaults.standard.string(forKey: "accessToken") else { print("Error: bearerToken is nil")
            return}
        
        networking.request(path: API.path, method: .get, operation: .userInfo, headers: ["Authorization" : "Bearer " + bearerToken], params: [:], body: nil) { data, statusCode, error in
            if error != nil {
                response(nil)
            }
            guard let JSONData = data else {response(nil); return}
            
            guard let decoded = self.decodeJSON(type: UserInfo.self, from: JSONData) else {
                return
            }
            
            response(decoded)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    func getBookList(params: [String : String], response: @escaping (([BookList?]) -> Void)) {
     
    }

    func getBookInfo(params: [String : String], response: @escaping (BookInfo?) -> Void) {
     
    }
     
    func getNearbyVehicles(params: [String: String], response: @escaping ([NearbyVehicleInfo]?) -> Void) {
        networking.request(path: API.path, operation: .getNearbyVehicles, params: params) { (data, statusCode, error) in
            if let _ = error {
                //showMessageBox(title: "Ошибка сети", message: error.localizedDescription)
                response(nil)
            }
            
            guard let JSONData = self.parseXML(from: data) else { response(nil); return }
                        
            let fault = self.decodeJSON(type: [Fault].self, from: JSONData)
            let decoded = self.decodeJSON(type: [NearbyVehicleInfo].self, from: JSONData)
            
            self.handleFault(data: fault)
            
            response(decoded)
        }
    }
    
    func getVehicleData(params: [String: String], response: @escaping ([VehicleInfo]?) -> Void) {
        networking.request(path: API.path, operation: .getVehicleData, params: params) { (data, statusCode, error) in
            if let error = error {
//                showMessageBox(title: "Ошибка сети", message: error.localizedDescription)
                response(nil)
            }
            
            guard let JSONData = self.parseXML(from: data) else { response(nil); return }
            
            let fault = self.decodeJSON(type: [Fault].self, from: JSONData)
            let decoded = self.decodeJSON(type: [VehicleInfo].self, from: JSONData)
            
            self.handleFault(data: fault)
            
            if fault == nil && decoded == nil {
//                showMessageBox(title: "Ошибка провайдера", message: "Запрос вернул пустые данные")
            }
            response(decoded)
        }
    }
        
    func probe(response: @escaping (Int) -> Void) {
        networking.getRequest(path: API.path, operation: .ping) { (data, statusCode, error) in
            
            //if let error = error {
            //    showMessageBox(title: "Ошибка сети", message: error.localizedDescription)
            //    response(0)
            //}
            
            response(statusCode)
        }
    }
    
    func handleFault(data: [Fault]?) {
        guard let fault = data?.first else { return }
        
        switch fault.code {
        case "1206":
            let description: String
            
            if fault.description.contains("Не найдена машина по ключу") {
                description = "Не найдена машина по указанному номеру"
            } else {
                description = fault.description
            }
            
//            showMessageBox(title: "Ошибка провайдера", message: description)
        
        default: break
//            showMessageBox(title: fault.description, message: fault.message)
        }
    }
    */
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type, from: data) else { return nil }
        return response
    }
}

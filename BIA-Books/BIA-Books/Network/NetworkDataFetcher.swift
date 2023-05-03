

import Foundation

enum fetcherErrors: Error {
    case busError(description: String)
}

protocol DataFetcher {

    
    func getBookList(params : [String : String], response : @escaping (([BookList?]) -> Void))
    func getBookInfo(response : @escaping (BookInfo?) -> Void)
    
    func login(params: [String: String], body: String?, response: @escaping (Login?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
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
    func getBookInfo(response: @escaping (BookInfo?) -> Void) {
//        networking.request(path: API.path, method: .get, operation: <#T##Operation#>, headers: <#T##[String : String]#>, params: <#T##[String : String]#>, body: <#T##String?#>, completion: <#T##(Data?, Int, Error?) -> Void#>)
    }
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
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

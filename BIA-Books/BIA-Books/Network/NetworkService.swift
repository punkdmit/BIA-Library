

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
}

protocol Networking {
    func request(path: String, method: Method, operation: Operation, headers: [String: String], params: [String: String], body: String?, completion: @escaping (Data?, Int, Error?) -> Void)
}

final class NetworkService: Networking {
    
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }
    
    func request(path: String, method: Method, operation: Operation, headers: [String: String], params: [String: String], body: String?, completion: @escaping (Data?, Int, Error?) -> Void) {
        let url = self.url(from: path + operation.rawValue, params: params)
        
        var request = URLRequest(url: url)
        
        switch method {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
            request.httpBody = body?.data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        
        // Headers
        headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = createDataTask(from: request, completion: completion)
        
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Int, Error?) -> Void) -> URLSessionDataTask {
        let urlSession = StaticURLSession.shared.urlSession
        
        return urlSession.dataTask(with: request) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            DispatchQueue.main.async {
                completion(data, statusCode, error)
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.port = API.port
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}

final class StaticURLSession: NSObject {
    lazy var urlSession: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    }()
    
    public func resetURLSession() {
        urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    }
    
    static let shared = StaticURLSession()
    
    override private init() { }
}

//extension StaticURLSession: URLSessionDelegate {
//
//    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//
//        switch challenge.protectionSpace.authenticationMethod {
//
//        case NSURLAuthenticationMethodServerTrust:
//
//            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, credential)
//            //completionHandler(.performDefaultHandling, nil)
//
//        case NSURLAuthenticationMethodClientCertificate:
//
//            completionHandler(.performDefaultHandling, nil)
//
//        default:
//
//            challenge.sender?.cancel(challenge)
//            completionHandler(.rejectProtectionSpace, nil)
//        }
//    }
//}

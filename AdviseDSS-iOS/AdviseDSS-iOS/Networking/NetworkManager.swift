//
//  NetworkManager.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 29/05/2024.
//

import Alamofire

typealias DataResponseHandler<T> = (DataResponseModel<T>) -> Void
internal class DataRequest : URLRequestConvertible {
    internal var url: String
    internal var method: HTTPMethod
    internal var data:Data?

    func asURLRequest() throws -> URLRequest {
        
        guard let urlRequest = try? URLRequest(url: url, method: method) else {
            throw AFError.invalidURL(url: self.url)
        }
        return urlRequest
    }
    
    private init(url:String, method: HTTPMethod = .get, rawData: Data? = nil) {
        self.url = url
        self.method = method
        self.data = rawData
    }
    convenience init<T:Encodable>(url:String, method: HTTPMethod = .get, object: T) {
        let jsonData = try? JSONEncoder().encode(object)
        self.init(url: url, method: method, rawData: jsonData)
    }
    convenience init(url:String, method: HTTPMethod = .get) {
        self.init(url: url, method: method, rawData: nil)
    }
}

protocol AlamofireNetworking {
    func run<T:Decodable>(_ request: DataRequest, completionHandler: @escaping DataResponseHandler<T>)
}


final class AlamofireNetworkManager: AlamofireNetworking {
    
    static let sharedInstance = AlamofireNetworkManager()
    private init() {
    }
    
    func run<T: Decodable>(_ request: DataRequest, completionHandler: @escaping DataResponseHandler<T>) {
        AF.request(request).validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let statusCode = response.response?.statusCode, 200..<300 ~= statusCode {
                    if let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                        completionHandler(DataResponseModel<T>(result: .success(decodedData)))
                    } else {
                        completionHandler(DataResponseModel<T>(result: .failure(self.getErrorModel(error: response.error))))
                    }
                } else {
                    let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.response?.statusCode ?? 0))
                    completionHandler(DataResponseModel<T>(result: .failure(self.getErrorModel(error: error))))
                }
            case .failure(let error):
                completionHandler(DataResponseModel<T>(result: .failure(self.getErrorModel(error: error))))
            }
        }
    }
    
    private func getErrorModel(error: AFError?) -> NetworkError {
        let nsError = NetworkError(statusCode: error?.responseCode ?? 0, errorMessage: error?.failureReason ?? "Something wrong happened")
        return nsError
    }
}

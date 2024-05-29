//
//  DataResponseModel.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 29/05/2024.
//

import Foundation

enum ResultType<T> {
    case success(T)
    case failure(NetworkError)
}
struct DataResponseModel<T> {
    let result: ResultType<T>
}

public struct NetworkError: Error, CustomStringConvertible {
    
    let statusCode: Int
    public var description: String

    init(statusCode: Int, errorMessage: String) {
        self.statusCode = statusCode
        self.description = errorMessage
    }
}

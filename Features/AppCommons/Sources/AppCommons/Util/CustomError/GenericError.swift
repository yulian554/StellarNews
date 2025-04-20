//
//  GenericError.swift
//  
//
//  Created by Yulian Hincapie on 17/04/25.
//

import Foundation

public class GenericError: Error {
    public let errorType: ErrorType
    public let message: String
    public let code: Int
    
    public init(errorType: ErrorType = .error, message: String, code: Int = 400) {
        self.errorType = errorType
        self.message = message
        self.code = code
    }
}

public enum ErrorType {
    case network
    case emptyResponse
    case error
}

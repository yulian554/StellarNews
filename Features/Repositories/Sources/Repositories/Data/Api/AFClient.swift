//
//  AFClient.swift
//  
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AppCommons
import Foundation
import Alamofire

public final class AFClient: Sendable {
    
    public static let shared = AFClient()
    
    private let baseUrl = Environments.baseUrl
    
    private init() {}
    
    func httpGet<T: Decodable>(path: String) async throws -> Result<T, GenericError> {
        var response: Result<T, AFError>
        var statusCode = 200
        
        let url = "\(baseUrl)\(path)"
        let value = AF.request(url).serializingDecodable(T.self)
        let status = await value.response.response?.statusCode
        let result = await value.result
        statusCode = status ?? 400
        response = result
    
        return try await withCheckedThrowingContinuation({ continuation in
            switch response {
            case .success(let success):
                continuation.resume(returning: .success(success))
            case .failure(_):
                continuation.resume(throwing: GenericError(message: "Eror en la api", code: statusCode))
            }
        })
    }
}

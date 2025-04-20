//
//  BaseDataSource.swift
//  AppCommons
//
//  Created by Yulian Hincapie on 19/04/25.
//

open class BaseDataSource: Sendable {
    
    public init() {}
    
    public func callApi<T>(
        action: () async throws -> Result<T, GenericError>
    ) async throws -> T {
        let response: Result<T, GenericError>
        
        do {
            response = try await action()
        } catch let error {
            let thisError = error as? GenericError
            response = .failure(thisError ?? GenericError(message: "Generic error"))
        }
        
        return try await withCheckedThrowingContinuation({ continuation in
            switch response {
            case .success(let success):
                continuation.resume(returning: success)
            case .failure(let failure):
                continuation.resume(throwing: failure)
            }
        })
    }
}

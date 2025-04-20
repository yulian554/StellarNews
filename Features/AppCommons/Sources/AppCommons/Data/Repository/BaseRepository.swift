//
//  BaseRepository.swift
//  AppCommons
//
//  Created by Yulian Hincapie on 19/04/25.
//

open class BaseRepository: Sendable {
    
    public init() {}
    
    public func callMethod<T, R>(
        action: () async throws -> T,
        mapper: BaseMapper<T, R>
    ) async throws -> R {
        var data: R?
        var mError: GenericError?
        
        do {
            let response = try await action()
            data = mapper.to(data: response)
        } catch let error {
            data = nil
            mError = error as? GenericError
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            guard let data else {
                return continuation.resume(throwing: mError ?? GenericError(message: "DefaultError"))
            }
            continuation.resume(returning: data)
        }
    }
    
}

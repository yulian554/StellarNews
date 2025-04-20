//
//  BaseUseCaseWithNetwork.swift
//  AppCommons
//
//  Created by Yulian Hincapie on 19/04/25.
//

open class BaseUseCaseWithNetwork: Sendable {
    
    public init() {}
    
    public func call<T>(
        action: () async throws -> T
    ) async throws -> T {
        if NetworkMonitor.shared.isNetworkConnectionAvailable() {
            return try await action()
        } else {
            return try await withCheckedThrowingContinuation({ continuation in
                return continuation.resume(
                    throwing: GenericError(errorType: .network, message: "NetworkError", code: 1000)
                )
            })
        }
    }
}

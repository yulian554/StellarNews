//
//  BaseViewModel.swift
//  AppCommons
//
//  Created by Yulian Hincapie on 20/04/25.
//

@MainActor
open class BaseViewModel: Sendable {
    
    public init() {}
    
    public func validateError(
        error: Error,
        forNetwork: () -> Void,
        forGenericError: () -> Void,
        forEmptyResponse: (() -> Void)? = nil
    ) {
        guard let error = error as? GenericError else {
            forGenericError()
            return
        }
        
        switch (error.errorType) {
        case .emptyResponse:
            forEmptyResponse?()
        case .network:
            forNetwork()
        case .error:
            forGenericError()
        }
    }
}

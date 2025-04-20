//
//  MockGetLatestArticlesUseCaseImpl.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import StellarNews
@testable import AppCommons
import Foundation

class MockGetLatestArticlesUseCaseImpl: GetLatestArticlesUseCase {
    var shouldSucceed = true
    var errorType: ErrorType = .error
    var mockArticles: [ArticlesEntity] = []
    
    func invoke(limit: String?) async throws -> [ArticlesEntity] {
        if shouldSucceed {
            return mockArticles
        } else {
            let error = switch (errorType) {
            case .network:
                GenericError(errorType: .network, message: "Error get latest articles")
            default:
                GenericError(message: "Error get latest articles")
            }
            return try await withCheckedThrowingContinuation({ continuation in
                return continuation.resume( throwing: error )
            })
            
            
        }
    }
}

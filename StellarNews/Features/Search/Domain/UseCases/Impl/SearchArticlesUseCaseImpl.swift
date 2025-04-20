//
//  SearchArticlesUseCaseImpl.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Repositories
import AppCommons

final class SearchArticlesUseCaseImpl: BaseUseCaseWithNetwork, SearchArticlesUseCase {
    private let repository: ArticlesRepository
    
    public init(repository: ArticlesRepository = ArticlesRepositoryImpl()) {
        self.repository = repository
    }
    
    public func invoke(query: String?) async throws -> [ArticlesEntity] {
        return try await call(
            action: {
                let response = try await repository.searchArticles(query: query ?? "")
                if ( response.isEmpty ) {
                    return try await withCheckedThrowingContinuation({ continuation in
                        return continuation.resume(
                            throwing: GenericError(errorType: .emptyResponse, message: "EmptyResponse", code: 200)
                        )
                    })
                }
                return response
            }
        )
    }
}

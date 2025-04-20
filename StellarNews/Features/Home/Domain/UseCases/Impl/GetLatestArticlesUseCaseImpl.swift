//
//  GetLatestArticlesUseCaseImpl.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AppCommons
import Repositories

public final class GetLatestArticlesUseCaseImpl: BaseUseCaseWithNetwork, GetLatestArticlesUseCase {
    
    private let repository: ArticlesRepository
    
    public init(repository: ArticlesRepository = ArticlesRepositoryImpl()) {
        self.repository = repository
    }
    
    public func invoke(limit: String?) async throws -> [ArticlesEntity] {
        return try await call(
            action: {
                try await repository.getLatestArticles(limit: limit ?? "10")
            }
        )
    }    
}

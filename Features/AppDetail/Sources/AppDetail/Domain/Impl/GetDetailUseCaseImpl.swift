//
//  GetDetailUseCaseImpl.swift
//  AppDetail
//
//  Created by Yulian Hincapie on 19/04/25.
//

import AppCommons
import Repositories

final class GetDetailUseCaseImpl: BaseUseCaseWithNetwork, GetDetailUseCase {
    
    private let repository: ArticlesRepository
    
    public init(repository: ArticlesRepository = ArticlesRepositoryImpl()) {
        self.repository = repository
    }
    
    public func invoke(id: String?) async throws -> ArticleDetailEntity {
        return try await call(
            action: { try await repository.getArticle(id: id ?? "") }
        )
    }
    
}

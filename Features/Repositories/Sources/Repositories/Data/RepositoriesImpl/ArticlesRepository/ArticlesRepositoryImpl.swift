//
//  ArticlesRepositoryImpl.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation
import AppCommons

public final class ArticlesRepositoryImpl: BaseRepository, ArticlesRepository {
    
    private let dataSource: ArticlesDataSource
    
    public init(dataSource: ArticlesDataSource = ArticlesDataSourceImpl()) {
        self.dataSource = dataSource
    }
    
    public func getLatestArticles(limit: String) async throws -> [ArticlesEntity] {
        return try await callMethod(
            action: { try await dataSource.getLatestArticles(limit: limit) },
            mapper: ArticlesEntityMapper() 
        )
    }
    
    public func searchArticles(query: String) async throws -> [ArticlesEntity] {
        return try await callMethod(
            action: { try await dataSource.searchArticles(query: query) },
            mapper: ArticlesEntityMapper()
        )
    }
    
    public func getArticle(id: String) async throws -> ArticleDetailEntity {
        return try await callMethod(
            action: { try await dataSource.getArticle(id: id) },
            mapper: ArticleDetailEntityMapper()
        )
    }
    
}

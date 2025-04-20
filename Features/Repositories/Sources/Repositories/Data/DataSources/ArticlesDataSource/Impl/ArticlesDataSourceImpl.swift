//
//  ArticlesDataSourceImpl.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation
import AppCommons

public final class ArticlesDataSourceImpl: BaseDataSource, ArticlesDataSource {
    
    private let apiClient: AFClient
    
    public init(apiClient: AFClient = AFClient.shared) {
        self.apiClient = apiClient
    }
    
    public func getLatestArticles(limit: String) async throws -> ArticlesResponse {
        let path = "/articles/?limit=\(limit)"
        return try await callApi(
            action: { try await apiClient.httpGet(path: path) }
        )
    }
    
    public func searchArticles(query: String) async throws -> ArticlesResponse {
        let path = "/articles/?search=\(query)"
        return try await callApi(
            action: { try await apiClient.httpGet(path: path) }
        )
    }
    
    public func getArticle(id: String) async throws -> ArticleDetailResponse {
        let path = "/articles/\(id)/"
        return try await callApi(
            action: { try await apiClient.httpGet(path: path) }
        )
    }
    
}

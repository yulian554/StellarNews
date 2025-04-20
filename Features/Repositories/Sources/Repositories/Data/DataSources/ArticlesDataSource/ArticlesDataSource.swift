//
//  ArticlesDataSource.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation
import AppCommons

public protocol ArticlesDataSource: Sendable {
    func getLatestArticles(limit: String) async throws -> ArticlesResponse
    func searchArticles(query: String) async throws -> ArticlesResponse
    func getArticle(id: String) async throws -> ArticleDetailResponse
    
}

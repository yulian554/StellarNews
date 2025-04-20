//
//  ArticlesRepository.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation
import AppCommons

public protocol ArticlesRepository: Sendable {
    func getLatestArticles(limit: String) async throws -> [ArticlesEntity]
    func searchArticles(query: String) async throws -> [ArticlesEntity]
    func getArticle(id: String) async throws -> ArticleDetailEntity
}

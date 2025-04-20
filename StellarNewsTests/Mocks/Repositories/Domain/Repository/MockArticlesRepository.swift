//
//  MockArticlesRepository.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

import Foundation
@testable import AppCommons
@testable import Repositories

final class MockArticlesRepository: ArticlesRepository, @unchecked Sendable {
    
    var searchArticlesCalled = false
    var getLatestArticlesCalled = false
    var getArticleCalled = false
    var articlesToReturn: [ArticlesEntity] = []
    var articleDetailToReturn: ArticleDetailEntity? = nil
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "test", code: 0)
    
    func searchArticles(query: String) async throws -> [ArticlesEntity] {
        searchArticlesCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return articlesToReturn
    }
    
    func getLatestArticles(limit: String) async throws -> [ArticlesEntity] {
        getLatestArticlesCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return articlesToReturn
    }
    
    func getArticle(id: String) async throws -> ArticleDetailEntity {
        getLatestArticlesCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return articleDetailToReturn ?? ArticleDetailEntity(
            id: nil,
            title: nil,
            authors: nil,
            url: nil,
            imageUrl: nil,
            newsSite: nil,
            summary: nil,
            publishedAt: nil,
            updatedAt: nil
        )
    }
}

//
//  MockSearchDelegate.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import StellarNews
@testable import AppCommons

class MockSearchDelegate: SearchDelegate {
    
    var didSearchArticlesEmptyCalled = false
    var didErrorSearchArticlesCalled = false
    var didErrorNetworkCalled = false
    var loadedArticles: [ArticlesUIModel]?
    
    func didSearchArticles(_ articles: [ArticlesUIModel]) {
        loadedArticles = articles
    }
    
    func didSearchArticlesEmpty() {
        didSearchArticlesEmptyCalled = true
    }
    
    func didErrorSearchArticles() {
        didErrorSearchArticlesCalled = true
    }
    
    func didNetworkError() {
        didErrorNetworkCalled = true
    }
}

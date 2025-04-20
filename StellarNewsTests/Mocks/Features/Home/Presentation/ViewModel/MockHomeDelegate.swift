//
//  MockHomeDelegate.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import StellarNews
@testable import AppCommons

class MockHomeDelegate: HomeDelegate {
    var didErrorLoadArticlesCalled = false
    var didErrorNetworkCalled = false
    var loadedArticles: [ArticlesUIModel]?
    
    func didLoadArticles(_ articles: [ArticlesUIModel]) {
        loadedArticles = articles
    }
    
    func didErrorLoadArticles() {
        didErrorLoadArticlesCalled = true
    }
    
    func didNetworkError() {
        didErrorNetworkCalled = true
    }
}

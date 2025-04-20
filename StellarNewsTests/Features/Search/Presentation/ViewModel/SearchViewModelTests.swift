//
//  HomeViewModelTests.swift
//  StellarNewsTests
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
@testable import StellarNews
@testable import AppCommons
@testable import Repositories

final class SearchViewModelTests: XCTestCase {
    
    private var mockDelegate: MockSearchDelegate?
    
    private let mockArticle = ArticlesEntity(
        id: 1,
        title: "Mock title",
        newsSite: "Mock newsSite",
        imageUrl: "Mock imageUrl"
    )
    
    func buildSut(useCase: MockSearchArticlesUseCaseImpl) async -> SearchViewModel {
        mockDelegate = MockSearchDelegate()
        
        return await SearchViewModel(
            delegate: mockDelegate,
            searchArticlesUseCase: useCase
        )
    }
    
    // MARK: - Tests
    func testSuccessfulArticleLoad() async {
        // Arrange
        let mockUseCase = MockSearchArticlesUseCaseImpl()
        mockUseCase.mockArticles = [mockArticle]
        let sut = await buildSut(useCase: mockUseCase)
        
        // Act
        await sut.searchProducts("")
        
        // Need to wait for async operations to complete
        await awaitForTest( completion: { expectation in await fulfillment(of: [expectation], timeout: 1.0) } )
        
        // Assert
        XCTAssertEqual(mockDelegate?.loadedArticles?.count ?? 0, 1)
        XCTAssertEqual(mockDelegate?.loadedArticles?.first?.title, mockArticle.title)
    }
    
    func testFailedArticleLoad() async {
        // Arrange
        let mockUseCase = MockSearchArticlesUseCaseImpl()
        mockUseCase.shouldSucceed = false
        let sut = await buildSut(useCase: mockUseCase)
        
        // Act
        await sut.searchProducts("")
        
        // Need to wait for async operations to complete
        await awaitForTest( completion: { expectation in await fulfillment(of: [expectation], timeout: 1.0) } )
        
        // Assert
        XCTAssertTrue(mockDelegate?.didErrorSearchArticlesCalled ?? false)
        XCTAssertNil(mockDelegate?.loadedArticles)
    }
    
    func testFailedArticleLoadByEmptyResponse() async {
        // Arrange
        let mockUseCase = MockSearchArticlesUseCaseImpl()
        mockUseCase.shouldSucceed = false
        mockUseCase.errorType = .emptyResponse
        let sut = await buildSut(useCase: mockUseCase)
        
        // Act
        await sut.searchProducts("")
        
        // Need to wait for async operations to complete
        await awaitForTest( completion: { expectation in await fulfillment(of: [expectation], timeout: 1.0) } )
        
        // Assert
        XCTAssertTrue(mockDelegate?.didSearchArticlesEmptyCalled ?? false)
        XCTAssertNil(mockDelegate?.loadedArticles)
    }
    
    func testFailedArticleLoadByNetwork() async {
        // Arrange
        let mockUseCase = MockSearchArticlesUseCaseImpl()
        mockUseCase.shouldSucceed = false
        mockUseCase.errorType = .network
        let sut = await buildSut(useCase: mockUseCase)
        
        // Act
        await sut.searchProducts("")
        
        // Need to wait for async operations to complete
        await awaitForTest( completion: { expectation in await fulfillment(of: [expectation], timeout: 1.0) } )
        
        // Assert
        XCTAssertTrue(mockDelegate?.didErrorNetworkCalled ?? false)
        XCTAssertNil(mockDelegate?.loadedArticles)
    }
}

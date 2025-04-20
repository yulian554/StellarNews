//
//  SearchArticlesUseCaseImplTests.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
@testable import StellarNews
@testable import AppCommons

class SearchArticlesUseCaseImplTests: XCTestCase {
    
    private let mockArticle = ArticlesEntity(
        id: 1,
        title: "Mock title",
        newsSite: "Mock newsSite",
        imageUrl: "Mock imageUrl"
    )
    
    func buildSut(repository: MockArticlesRepository) -> SearchArticlesUseCaseImpl {
        return SearchArticlesUseCaseImpl(
            repository: repository
        )
    }
    
    // MARK: - Tests
    
    func testInvokeCallsRepository() async {
        // Arrange
        let mockRepository = MockArticlesRepository()
        mockRepository.articlesToReturn = [mockArticle]
        
        let useCase = buildSut(repository: mockRepository)
        
        // Act
        do {
            let result = try await useCase.invoke(query: nil)
            
            // Assert
            XCTAssertTrue(mockRepository.searchArticlesCalled)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
    
    func testInvokeWithEmptyResponseThrowsError() async {
        // Arrange
        let mockRepository = MockArticlesRepository()
        mockRepository.articlesToReturn = []
        
        let useCase = buildSut(repository: mockRepository)
        
        // Act & Assert
        do {
            _ = try await useCase.invoke(query: "test")
            XCTFail("Should throw an error for empty response")
        } catch let error as GenericError {
            XCTAssertEqual(error.errorType, .emptyResponse)
            XCTAssertEqual(error.code, 200)
        } catch {
            XCTFail("Threw wrong error type: \(error)")
        }
    }
}

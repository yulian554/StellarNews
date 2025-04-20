//
//  DetailViewModelTest.swift
//  AppDetail
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
@testable import AppDetail
@testable import AppCommons

@MainActor
class DetailViewModelTests: XCTestCase {
    
    var viewModel: DetailViewModel!
    var mockGetDetailUseCase: MockGetDetailUseCase!
    
    override func setUp() async throws {
        mockGetDetailUseCase = MockGetDetailUseCase()
        viewModel = DetailViewModel(
            state: .loadin,
            getDetailUseCase: mockGetDetailUseCase
        )
    }
    
    override func tearDown() async throws {
        viewModel = nil
        mockGetDetailUseCase = nil
    }
    
    func testLoadDetailSuccess() async {
        // Arrange
        let mockEntity = ArticleDetailEntity(
            id: 123,
            title: "Test Article",
            authors: [],
            url: "https://example.com",
            imageUrl: "https://example.com/image.jpg",
            newsSite: "Test Site",
            summary: "Test summary",
            publishedAt: "2023-01-01",
            updatedAt: "2023-01-01"
        )
        
        mockGetDetailUseCase.resultToReturn = mockEntity
        
        // Act
        await viewModel.loadDetail(id: "123")
        
        guard case let .success(articleDetail) = viewModel.state else {
            XCTFail("El estado debería ser .success pero fue \(viewModel.state)")
            return
        }
        
        // Assert
        XCTAssertEqual(articleDetail.id, 123)
        XCTAssertEqual(articleDetail.title, "Test Article")
        XCTAssertEqual(articleDetail.imageUrl, "https://example.com/image.jpg")
        XCTAssertEqual(articleDetail.summary, "Test summary")
    }
    
    func testLoadDetailNetworkError() async {
        // Arrange
        let networkError = GenericError(errorType: .network, message: "")
        mockGetDetailUseCase.errorToThrow = networkError
        
        // Act
        await viewModel.loadDetail(id: "123")
        
        // Assert
        guard case let .failure(errorType) = viewModel.state else {
            XCTFail("El estado debería ser .failure pero fue \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(errorType, .errorNetworkDetail)
    }
    
    func testLoadDetailGenericError() async {
        // Arrange
        let genericError = NSError(domain: "TestDomain", code: 123, userInfo: nil)
        mockGetDetailUseCase.errorToThrow = genericError
        
        // Act
        await viewModel.loadDetail(id: "123")
        
        // Assert
        guard case let .failure(errorType) = viewModel.state else {
            XCTFail("El estado debería ser .failure pero fue \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(errorType, .errorLoadDetail)
    }
}

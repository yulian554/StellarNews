//
//  SearchViewControllerTests.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
@testable import StellarNews
@testable import AppCommons

class SearchViewControllerTests: XCTestCase {
    
    var viewController: SearchViewController!
    var mockViewModel: MockSearchViewModel!
    var mockRedirect: MockRedirectGlobalImpl!
    
    @MainActor
    override func setUpWithError() throws {
        try super.setUpWithError()

        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "Search") as? SearchViewController
        
        mockViewModel = MockSearchViewModel()
        mockRedirect = MockRedirectGlobalImpl()
        
        viewController.loadViewIfNeeded()
        
        viewController.viewModel = mockViewModel
        viewController.redirect = mockRedirect
    }
    
    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        mockRedirect = nil
        super.tearDown()
    }
    
    // MARK: - Tests de inicialización
    
    func testViewDidLoadSetsUpView() {
        
        // Verifica que el delegado del textField esté configurado
        XCTAssertTrue(viewController.searchTextField.delegate === viewController)
        
        // Verifica que el placeholder esté configurado
        let placeholder = viewController.searchTextField.attributedPlaceholder
        XCTAssertEqual(placeholder?.string, "Encuentra tu articulo aquí")
        
        // Verifica que el collection view esté configurado
        XCTAssertTrue(viewController.itemsCollectionView.delegate === viewController)
        XCTAssertTrue(viewController.itemsCollectionView.dataSource === viewController)
    }
    
    // MARK: - Tests de búsqueda
    @MainActor
    func testTextFieldShouldReturnWithEmptyTextDoesNotCallViewModel() {
        // Arrange
        viewController.searchTextField.text = ""
        
        // Act
        _ = viewController.textFieldShouldReturn(viewController.searchTextField)
        
        // Assert
        XCTAssertFalse(mockViewModel.searchProductsCalled)
    }
    
    @MainActor
    func testTextFieldShouldReturnWithSameSearchDoesNotCallViewModel() {
        // Arrange
        viewController.lastSearch = "previous search"
        viewController.searchTextField.text = "previous search"
        
        // Act
        _ = viewController.textFieldShouldReturn(viewController.searchTextField)
        
        // Assert
        XCTAssertFalse(mockViewModel.searchProductsCalled)
    }
    
    // MARK: - Tests de delegado
    
    func testDidSearchArticlesUpdatesArticlesAndStopsShimmer() {
        // Arrange
        let mockArticles = [
            ArticlesUIModel(id: 1, title: "Test Article", newsSite: nil, imageUrl: "")
        ]
        
        // Act
        viewController.didSearchArticles(mockArticles)
        
        // Assert
        XCTAssertEqual(viewController.articles.count, 1)
        XCTAssertEqual(viewController.articles[0].id, 1)
        XCTAssertEqual(viewController.articles[0].title, "Test Article")
    }
    
    func testDidSearchArticlesEmptyClearsArticlesAndShowsAlert() {
        // Arrange
        viewController.articles = [
            ArticlesUIModel(id: 1, title: "Test Article", newsSite: nil, imageUrl: "")
        ]
        viewController.lastSearch = "test"
        
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        // Act
        viewController.didSearchArticlesEmpty()
        
        // Assert
        XCTAssertEqual(viewController.articles.count, 0)
        XCTAssertEqual(viewController.lastSearch, "")
        
        // Espera a que se presente el alert
        let expectation = XCTestExpectation(description: "Alert should be presented")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let presentedVC = self.viewController.presentedViewController
            XCTAssertTrue(presentedVC is UIAlertController)
            if let alert = presentedVC as? UIAlertController {
                XCTAssertEqual(alert.title, "Sin Articulos")
                XCTAssertEqual(alert.message, "No encontramos Articulos para esta busqueda.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Tests de CollectionView
    
    func testCollectionViewNumberOfItemsReturnsArticlesCount() {
        // Arrange
        viewController.articles = [
            ArticlesUIModel(id: 1, title: "Article 1", newsSite: "", imageUrl: ""),
            ArticlesUIModel(id: 2, title: "Article 2", newsSite: "", imageUrl: "")
        ]
        
        // Act
        let result = viewController.collectionView(viewController.itemsCollectionView, numberOfItemsInSection: 0)
        
        // Assert
        XCTAssertEqual(result, 2)
    }
    
    func testCollectionViewDidSelectItemNavigatesToDetail() {
        // Arrange
        viewController.articles = [
            ArticlesUIModel(id: 123, title: "Test Article", newsSite: "", imageUrl: "")
        ]
        
        let navController = UINavigationController(rootViewController: viewController)
        
        // Act
        viewController.collectionView(viewController.itemsCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        // Assert
        XCTAssertTrue(mockRedirect.navigateToDetailCalled)
        XCTAssertEqual(mockRedirect.lastNavigationController, navController)
        XCTAssertEqual(mockRedirect.lastDetailId, 123)
    }
}

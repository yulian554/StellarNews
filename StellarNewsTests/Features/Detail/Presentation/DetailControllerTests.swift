//
//  DetailControllerTests.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
import SwiftUI
@testable import StellarNews
@testable import AppDetail

class DetailControllerTests: XCTestCase {
    
    var navigationController: MockNavigationController!
    var detailController: DetailController!
    
    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        detailController = DetailController(navigationController: navigationController)
    }
    
    override func tearDown() {
        navigationController = nil
        detailController = nil
        super.tearDown()
    }
    
    func testInitSetsNavigationController() {
        // Verifica que el navegador se asigna correctamente en la inicialización
        XCTAssertTrue(detailController.navigationController === navigationController)
    }
    
    func testOpenViewPushesHostingController() {
        // Acción
        detailController.openView(id: 123)
        
        // Verificación
        XCTAssertEqual(navigationController.pushedViewControllers.count, 1)
        XCTAssertTrue(navigationController.lastAnimatedFlag)
    }
    
    func testGestureRecognizerShouldBeginReturnsFalseWhenOnlyOneViewController() {
        // Configuración - simular un solo view controller en la pila
        navigationController.viewControllersToReturn = [UIViewController()]
        
        // Acción
        let result = detailController.gestureRecognizerShouldBegin(UIGestureRecognizer())
        
        // Verificación
        XCTAssertFalse(result)
    }
    
    func testErrorLoadDetailShowsErrorAndPops() {
        // Acción
        detailController.error(type: .errorLoadDetail)
        
        // Verificación
        XCTAssertTrue(navigationController.popViewControllerCalled)
        XCTAssertTrue(navigationController.lastAnimatedFlag)
    }
    
    func testGoBackPopsViewController() {
        // Acción
        detailController.goBack()
        
        // Verificación
        XCTAssertTrue(navigationController.popViewControllerCalled)
        XCTAssertTrue(navigationController.lastAnimatedFlag)
    }
}

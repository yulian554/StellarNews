//
//  MockRedirectGlobalImpl.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import StellarNews
import UIKit

class MockRedirectGlobalImpl: RedirectGlobal {
    var navigateToSearchCalled = false
    var navigateToDetailCalled = false
    var navigateToProfileCalled = false
    var lastNavigationController: UINavigationController?
    var lastDetailId: Int64?
    
    func navigateToSearch(navigationController: UINavigationController) {
        navigateToSearchCalled = true
        lastNavigationController = navigationController
    }
    
    func navigateToDetail(navigationController: UINavigationController, id: Int64?) {
        navigateToDetailCalled = true
        lastNavigationController = navigationController
        lastDetailId = id
    }
    
    func navigateToProfile(navigationController: UINavigationController) {
        navigateToProfileCalled = true
        lastNavigationController = navigationController
    }
}

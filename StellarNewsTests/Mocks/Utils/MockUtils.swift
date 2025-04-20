//
//  MockUtils.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

import UIKit

class MockNavigationController: UINavigationController {
    var pushedViewControllers: [UIViewController] = []
    var popViewControllerCalled = false
    var lastAnimatedFlag = false
    var viewControllersToReturn: [UIViewController] = []
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
        lastAnimatedFlag = animated
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        lastAnimatedFlag = animated
        return nil
    }
}

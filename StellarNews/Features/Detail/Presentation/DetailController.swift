//
//  DetailController.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit
import AppDetail
import SwiftUI
import AppCommons

class DetailController: NSObject {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openView(id: Int64?) {
        setupInteractivePopGestureRecognizer()
        let viewController = UIHostingController(rootView: self.getView(id: id))
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    private func getView(id: Int64?) -> some View {
        let finalId = id == nil ? "" : "\(id!)"
        return DetailView(id: finalId, delegate: self)
    }
    
    private func setupInteractivePopGestureRecognizer() {
        self.navigationController.interactivePopGestureRecognizer?.delegate = self
    }
}

extension DetailController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController.viewControllers.count > 1
    }
}

extension DetailController: DetailDelegate {
    func error(type: DetailsErrors) {
        switch (type) {
        case .errorNetworkDetail:
            showGenericNettworkError(context: navigationController)
        case .errorLoadDetail:
            showGenericError(context: navigationController)
        }
        navigationController.popViewController(animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
}

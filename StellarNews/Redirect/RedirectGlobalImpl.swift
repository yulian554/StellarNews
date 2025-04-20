//
//  RedirectGlobalImpl.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit
import AppCommons

class RedirectGlobalImpl: RedirectGlobal {

    func navigateToSearch(navigationController: UINavigationController) {
        let key = "Search"
        let storyboard = UIStoryboard(name: key, bundle: nil)
        if let searchController = storyboard.instantiateViewController(withIdentifier: key) as? SearchViewController {
            navigationController.pushViewController(searchController, animated: true)
        }
    }
    
    func navigateToDetail(navigationController: UINavigationController, id: Int64?) {
        DetailController(navigationController: navigationController).openView(id: id)
    }
    
    func navigateToProfile(navigationController: UINavigationController) {
        let key = "Profile"
        let storyboard = UIStoryboard(name: key, bundle: nil)
        if let profileController = storyboard.instantiateViewController(withIdentifier: key) as? ProfileViewController {
            navigationController.pushViewController(profileController, animated: true)
        }
    }
    
}

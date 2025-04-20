//
//  RedirectGlobal.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit
import AppCommons

protocol RedirectGlobal: AnyObject {
    func navigateToSearch(navigationController: UINavigationController)
    func navigateToDetail(navigationController: UINavigationController, id: Int64?)
    func navigateToProfile(navigationController: UINavigationController)
}

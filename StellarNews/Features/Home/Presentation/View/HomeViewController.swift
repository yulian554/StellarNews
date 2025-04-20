//
//  ViewController.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 17/04/25.
//

import UIKit
import SkeletonView
import AppCommons

class HomeViewController: UIViewController {

    @IBOutlet weak var search: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    
    lazy var viewModel: HomeViewModel = HomeViewModel(delegate: self)
    lazy var articles: [ArticlesUIModel] = []
    lazy var redirect: RedirectGlobal? = RedirectGlobalImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadHome()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in }, completion: { _ in
            self.reloadLayouts()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.reloadLayouts()
            self.updatePhoto()
        })
    }
    
    private func reloadLayouts() {
        self.bannersCollectionView.collectionViewLayout.invalidateLayout()
        self.bannersCollectionView.reloadData()
    }
    
    private func setUpView() {
        setUpBanners()
        setupSearchView()
        setupUserImage()
    }
    
    private func setUpBanners() {
        setupBannersCollectionView()
        bannersCollectionView.reloadData()
        bannersCollectionView.showAnimatedGradientSkeleton(transition: .none)
    }
    
    private func reloadBanners() {
        self.bannersCollectionView.hideSkeleton()
        self.bannersCollectionView.reloadData()
    }
    
    private func setupSearchView() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.actionSearch (_:)))
        search.addGestureRecognizer(gesture)
    }
    
    @objc func actionSearch(_ sender: UITapGestureRecognizer) {
        guard let navigationController else { return }
        redirect?.navigateToSearch(navigationController: navigationController)
    }
    
    private func setupUserImage() {
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.actionUserImage (_:)))
        userImage.addGestureRecognizer(gesture)
        
        updatePhoto()
    }
    
    @objc func actionUserImage(_ sender: UITapGestureRecognizer) {
        guard let navigationController else { return }
        redirect?.navigateToProfile(navigationController: navigationController)
    }
    
    private func loadHome() {
        viewModel.getRecentArticles()
    }
    
    private func updatePhoto() {
        guard let image = viewModel.getPhoto(), let imageData = Data(base64Encoded: image) else {
            userImage.image = UIImage(systemName: "person.fill")
            return
        }
        userImage.image = UIImage(data: imageData)
    }

}

extension HomeViewController: HomeDelegate {
    func didNetworkError() {
        showGenericNettworkError(context: self)
    }
    
    
    func didErrorLoadArticles() {
        showGenericError(context: self)
        reloadBanners()
    }
    
    func didLoadArticles(_ articles: [ArticlesUIModel]) {
        self.articles = articles
        reloadBanners()
    }
}

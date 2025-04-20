//
//  SearchViewController.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit
import AppCommons
import SkeletonView

class SearchViewController: UIViewController {
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    lazy var viewModel: SearchViewModel = SearchViewModel(delegate: self)
    lazy var articles: [ArticlesUIModel] = []
    var lastSearch = ""
    
    lazy var redirect: RedirectGlobal? = RedirectGlobalImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in }, completion: { _ in
            self.reloadLayouts()
        })
    }
    
    private func reloadLayouts() {
        self.itemsCollectionView.collectionViewLayout.invalidateLayout()
        self.itemsCollectionView.reloadData()
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpView() {
        setUpSearch()
        setUpItems()
    }
    
    private func setUpItems() {
        setupItemsCollectionView()
    }
    
    private func setUpSearch() {
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Encuentra tu articulo aquí",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        searchTextField.becomeFirstResponder()
    }
    
    private func showShimmer() {
        self.itemsCollectionView.reloadData()
        self.itemsCollectionView.showAnimatedGradientSkeleton(transition: .none)
    }
    
    private func stopShimmer() {
        self.itemsCollectionView.hideSkeleton()
        self.itemsCollectionView.reloadData()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let complement = textField.text, !complement.isEmpty , lastSearch != complement {
            showShimmer()
            itemsCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            lastSearch = complement
            viewModel.searchProducts(complement)
        }
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: SearchDelegate {
    func didSearchArticlesEmpty() {
        self.articles = []
        lastSearch = ""
        stopShimmer()
        showAlertMessage(
            context: self,
            title: "Sin Articulos",
            message: "No encontramos Articulos para esta busqueda.",
            textOkButton: "Ok"
        )
    }
    
    func didNetworkError() {
        showGenericNettworkError(context: self)
    }
    
    func didSearchArticles(_ articles: [ArticlesUIModel]) {
        self.articles = articles
        stopShimmer()
    }
    
    func didErrorSearchArticles() {
        stopShimmer()
    }
}

extension SearchViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}

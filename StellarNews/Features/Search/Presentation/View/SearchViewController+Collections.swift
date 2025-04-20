//
//  SearchViewController+Collections.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit
import SkeletonView
import AppCommons

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func setupItemsCollectionView() {
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        itemsCollectionView.register(
            UINib(nibName: SearchItemCollectionViewCell.identifier,bundle: nil),
            forCellWithReuseIdentifier: SearchItemCollectionViewCell.identifier
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return buildItemsCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let article = articles[safe: indexPath.row] else { return }
        initRedirect(id: article.id)
    }
    
}

extension SearchViewController: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return SearchItemCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
}

extension SearchViewController {
    
    func buildItemsCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = itemsCollectionView.dequeueReusableCell(
            withReuseIdentifier: SearchItemCollectionViewCell.identifier,
            for: indexPath
        ) as? SearchItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let article = articles[safe: indexPath.row] { cell.initView(data: article) }
        return cell
    }
    
    func initRedirect(id: Int64?) {
        guard let navigationController else { return }
        redirect?.navigateToDetail(navigationController: navigationController, id: id)
    }
    
}

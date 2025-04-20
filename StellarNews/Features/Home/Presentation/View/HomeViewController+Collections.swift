//
//  HomeViewController+Collections.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 17/04/25.
//

import UIKit
import AppCommons
import SkeletonView

fileprivate enum CellIdHome: String {
    case bannersID = "BannerCollectionViewCell"
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return buildBannersCell(indexPath)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let isPortrait = UIDevice.current.orientation.isPortrait || UIDevice.current.orientation.isFlat
            
        if isPortrait {
            return CGSize(width: collectionView.bounds.width - 50, height: 210)
        } else {
            return CGSize(width: collectionView.bounds.width / 2 - 24, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let article = articles[safe: indexPath.row] else { return }
        initRedirect(id: article.id)
    }
    
    func setupBannersCollectionView() {
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        bannersCollectionView.register(
            UINib(nibName: CellIdHome.bannersID.rawValue, bundle: nil),
            forCellWithReuseIdentifier: BannerCollectionViewCell.identifier
        )
    }
}

extension HomeViewController: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        return BannerCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

// MARK: Build cells
fileprivate extension HomeViewController {
    func buildBannersCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bannersCollectionView.dequeueReusableCell(
            withReuseIdentifier: CellIdHome.bannersID.rawValue,
            for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        if !articles.isEmpty { cell.initView(data: articles[indexPath.row]) }
        return cell
    }
    
    func initRedirect(id: Int64?) {
        guard let navigationController else { return }
        redirect?.navigateToDetail(navigationController: navigationController, id: id)
    }
}

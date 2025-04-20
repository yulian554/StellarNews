//
//  SearchItemCollectionViewCell.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit
import AppCommons
import SDWebImage

class SearchItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var newsSiteLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueLabel: UILabel!
    
    static let identifier = "SearchItemCollectionViewCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
        image.layer.cornerRadius = 20
        labelsView.layer.cornerRadius = 20
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        labelsView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        continueLabel.isHidden = true
    }
    
    func initView(data: ArticlesUIModel) {
        setupView(data: data)
    }
    
    private func setupView(data: ArticlesUIModel) {
        continueLabel.isHidden = false
        titleLabel.text = data.title ?? ""
        newsSiteLabel.text = data.newsSite ?? ""
        image.sd_setImage(with: URL(string: data.imageUrl ?? ""))
    }

}

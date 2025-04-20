//
//  BannerCollectionViewCell.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 17/04/25.
//

import UIKit
import AppCommons
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsSiteLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelView: UIView!
    
    static let identifier = "BannerCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
        image.layer.cornerRadius = 20
        labelView.layer.cornerRadius = 20
    }
    
    func initView(data: ArticlesUIModel) {
        setupView(data: data)
    }
    
    private func setupView(data: ArticlesUIModel) {
        titleLabel.text = data.title ?? ""
        newsSiteLabel.text = data.newsSite ?? ""
        image.sd_setImage(with: URL(string: data.imageUrl ?? ""))
    }

}

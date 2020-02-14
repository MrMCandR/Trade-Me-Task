//
//  ListingPreviewCollectionViewCell.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import Kingfisher

class ListingPreviewCollectionViewCell: AnimatedCollectionViewCell {
    
    // MARK: Inteface Builder Components
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var listingImageView: UIImageView!
    
    @IBOutlet weak var mainWrapperView: UIView!
    @IBOutlet weak var mainWrapperShadowView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var detailsWrapperView: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        mainWrapperView.roundCorners()
        mainWrapperShadowView.roundCorners()
        mainWrapperShadowView.addShadow()
        separatorView.backgroundColor = Constants.Colors.extraLightGray
    }
    
    public func configure(withListingPreview listingPreview: ListingPreview) {
        titleLabel.text = listingPreview.title
        regionLabel.text = listingPreview.region
        priceLabel.text = listingPreview.priceDisplay
        
        listingImageView.image = Utils.randomKevin()
        if let imageURLString = listingPreview.pictureHref, let imageURL = URL(string: imageURLString) {
            listingImageView.kf.indicatorType = .activity
            listingImageView.kf.setImage(with: imageURL)
        }
    }
}

// MARK: - Nib Helper Extensions
extension ListingPreviewCollectionViewCell: NibInstantiatable {
    static var reuseId: String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: reuseId, bundle: nil)
    }
}

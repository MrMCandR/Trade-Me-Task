//
//  CategoryCell.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import ImageSlideshow

class ImageCell: UITableViewCell {
    
    // MARK: - Inteface Builder Components
    @IBOutlet weak var cellImageView: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.contentScaleMode = .scaleAspectFill
        cellImageView.slideshowInterval = 3
    }
    
    func configure(withImageItem imageItem: ImageItemModel) {
        // Compact map all URL strings into Kingfisher image sources
        cellImageView.setImageInputs(imageItem.imageURLs.compactMap({ (urlString) -> KingfisherSource? in
            KingfisherSource(urlString: urlString)
        }))
    }
}

// MARK: - Nib Helper Extensions
extension ImageCell: NibInstantiatable {
    static var reuseId: String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: reuseId, bundle: nil)
    }
}

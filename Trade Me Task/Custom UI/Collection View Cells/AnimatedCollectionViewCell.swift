//
//  AnimatedCollectionViewCell.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 14/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

class AnimatedCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLongPressAnimation()
    }
    
    private func setupLongPressAnimation() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(AnimatedCollectionViewCell.logPressChanged(sender:)))
        longPressRecognizer.minimumPressDuration = 0.1
        contentView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc private func logPressChanged(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            animateTap(active: true, options: .curveEaseIn)
        case .ended:
            animateTap(active: false, options: .curveEaseIn)
        default:
            break
        }
    }
    
    public func tapAnimation() {
        animateTap(active: true) {
            self.animateTap(active: false)
        }
    }
    
    public func animateTap(active: Bool, options: UIView.AnimationOptions = .curveEaseOut, completion: (() -> ())? = nil) {
        let animation = {
            self.contentView.transform = active ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
        }

        UIView.animate(withDuration: Constants.Animation.scaleAnimationDuration, delay: 0, options: .curveEaseIn, animations: {
            animation()
        }) { (complete) in
            completion?()
        }
    }
}

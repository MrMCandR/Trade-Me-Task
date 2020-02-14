//
//  UIView+Layer.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.separator.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func removeShadow() {
        self.layer.shadowOpacity = 0
    }
    
    func roundCorners(withRadius radius: CGFloat = Constants.UI.defaultCornerRadius) {
        self.layer.cornerRadius = radius
    }
    
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

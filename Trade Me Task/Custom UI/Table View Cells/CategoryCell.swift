//
//  CategoryCell.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    // MARK: - Inteface Builder Components
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circlularView: CircularView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Logic Components
    private var loadedCategory: Category?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        tintColor = Constants.Colors.tmYellow
        circlularView.backgroundColor = Constants.Colors.tmYellow
    }
    
    func configure(withCategory category: Category) {
        loadedCategory = category
        titleLabel.text = category.name
        iconImageView.tintColor = Constants.Colors.tmBlack
        
        if let icon = Utils.getIcon(forCategoryName: category.name) {
            iconImageView.image = icon
            circlularView.isHidden = false
        } else {
            circlularView.isHidden = true
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        circlularView.backgroundColor = Constants.Colors.tmYellow
        if selected {
            backgroundColor = UIColor.systemGray
        } else {
            backgroundColor = UIColor.secondarySystemGroupedBackground
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        circlularView.backgroundColor = Constants.Colors.tmYellow
        if highlighted {
            backgroundColor = UIColor.systemGray
        } else {
            backgroundColor = UIColor.secondarySystemGroupedBackground
        }
    }
}

// MARK: - Nib Helper Extensions
extension CategoryCell: NibInstantiatable {
    static var reuseId: String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: reuseId, bundle: nil)
    }
}

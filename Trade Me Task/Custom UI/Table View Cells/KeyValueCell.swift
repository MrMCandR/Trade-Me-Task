//
//  KeyValueCell.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

class KeyValueCell: UITableViewCell {
    
    func configure(withKeyValueItem keyValueItem: KeyValueItemModel) {
        textLabel?.text = keyValueItem.key
        detailTextLabel?.text = keyValueItem.value
    }
}

// MARK: - Nib Helper Extensions
extension KeyValueCell: NibInstantiatable {
    static var reuseId: String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: reuseId, bundle: nil)
    }
}

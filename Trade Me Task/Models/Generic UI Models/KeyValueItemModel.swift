//
//  KeyValueItemModel.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

class KeyValueItemModel: GenericUIItemModel {
    let key: String
    let value: String?
    
    init(withKey key: String, withValue value: String) {
        self.key = key
        self.value = value
    }
}

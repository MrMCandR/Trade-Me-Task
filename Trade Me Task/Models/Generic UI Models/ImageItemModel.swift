//
//  ImageItemModel.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

class ImageItemModel: GenericUIItemModel {
    let imageURLs: [String]
    
    init(withImageURLs imageURLs: [String]) {
        self.imageURLs = imageURLs
    }
}

//
//  SearchResult.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let totalCount: Int
    let page: Int
    let pageSize: Int
    let listings: [ListingPreview]
    let didYouMean: String
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case page       = "Page"
        case pageSize   = "PageSize"
        case listings   = "List"
        case didYouMean = "DidYouMean"
    }
}

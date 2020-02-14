//
//  Category.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

struct Category: Codable {
    let name: String
    let number: String
    let path: String
    let subCategories: [Category]
    let count: Int
    let isLeaf: Bool
    
    enum CodingKeys: String, CodingKey {
        case name           = "Name"
        case number         = "Number"
        case path           = "Path"
        case subCategories  = "Subcategories"
        case count          = "Count"
        case isLeaf         = "IsLeaf"
    }
}

// MARK: - custom decode on a per-key basis (allows for explicit coalescing)
extension Category {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let number = try container.decode(String.self, forKey: .number)
        let isLeaf = try container.decode(Bool.self, forKey: .isLeaf)
        
        let path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
        let categories = try container.decodeIfPresent([Category].self, forKey: .subCategories) ?? []
        let count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        
        self.init(name: name, number: number, path: path, subCategories: categories, count: count, isLeaf: isLeaf)
    }
}

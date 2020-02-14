//
//  Member.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

struct Member: Codable {
    let memberId: Int
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case memberId = "MemberId"
        case nickname = "Nickname"
    }
}

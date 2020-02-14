//
//  Image.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

enum THPhotoError: Error {
    case photoURLMissingError
}

enum PhotoSize {
    case thumbnail
    case list
    case medium
    case gallery
    case large
    case fullSize
}

struct Photo: Codable {
    let key: Int
    let value: PhotoValue
    
    enum CodingKeys: String, CodingKey {
        case key    = "Key"
        case value  = "Value"
    }
    
    // Helper function for extracting photo at given size
    func extractPhotoURL(forPhotoSize photoSize: PhotoSize) -> String? {
        switch photoSize {
        case .thumbnail:
            return value.thumbnail
        case .list:
            return value.list
        case .medium:
            return value.medium
        case .gallery:
            return value.gallery
        case .large:
            return value.large
        case .fullSize:
            return value.fullSize
        }
    }
}

struct PhotoValue: Codable {
    let photoId: Int
    let thumbnail: String?
    let list: String?
    let medium: String?
    let gallery: String?
    let large: String?
    let fullSize: String?
    
    enum CodingKeys: String, CodingKey {
        case photoId    = "PhotoId"
        case thumbnail  = "Thumbnail"
        case list       = "List"
        case medium     = "Medium"
        case gallery    = "Gallery"
        case large      = "Large"
        case fullSize   = "FullSize"
    }
}

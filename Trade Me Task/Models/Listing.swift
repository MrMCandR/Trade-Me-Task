//
//  Listing.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

struct ListingPreview: Codable {
    let listingId: Int
    let title: String
    let priceDisplay: String
    let pictureHref: String?
    let region: String
    let category: String
    let categoryPath: String
    
    enum CodingKeys: String, CodingKey {
        case listingId      = "ListingId"
        case title          = "Title"
        case priceDisplay   = "PriceDisplay"
        case pictureHref    = "PictureHref"
        case region         = "Region"
        case category       = "Category"
        case categoryPath   = "CategoryPath"
    }
}

struct ListingDetail: Codable {
    let listingId: Int
    let title: String
    let priceDisplay: String
    let pictureHref: String?
    let region: String
    let category: String
    let categoryPath: String
    let subtitle: String?
    let startPrice: Double
    let startDate: String
    let endDate: String
    let hasBuyNow: Bool?
    let buyNowPrice: Double?
    let hasReserve: Bool?
    let reserveState: Int?
    let photos: [Photo]?
    let member: Member?
    
    enum CodingKeys: String, CodingKey {
        case listingId      = "ListingId"
        case title          = "Title"
        case priceDisplay   = "PriceDisplay"
        case pictureHref    = "PictureHref"
        case region         = "Region"
        case category       = "Category"
        case categoryPath   = "CategoryPath"
        case subtitle       = "Subtitle"
        case startPrice     = "StartPrice"
        case startDate      = "StartDate"
        case endDate        = "EndDate"
        case hasBuyNow      = "HasBuyNow"
        case buyNowPrice    = "BuyNowPrice"
        case hasReserve     = "HasReserve"
        case reserveState   = "ReserveState"
        case photos         = "Photos"
        case member         = "Member"
    }
    
    // MARK: - Flat map extraction of any available photo URLs, at a given size
    func getPhotoURLs(forPhotoSize photoSize: PhotoSize) -> [String] {
        return photos?.compactMap({ (photo) -> String? in
            photo.extractPhotoURL(forPhotoSize: photoSize)
        }) ?? []
    }
}

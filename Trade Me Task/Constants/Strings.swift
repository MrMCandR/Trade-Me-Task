//
//  Strings.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

struct Strings {
    static let SearchTableViewTitle = NSLocalizedString("Browse", comment: "Search Table View Controller Title")
    
    // MARK: - Empty Data Set Strings
    static let DefaultEmptyDataSetTitle                 = NSLocalizedString("Nothing to See Here...", comment: "Default Empty Data Set Title")
    static let SearchTableViewEmptyTitle                = NSLocalizedString("No Categories Found", comment: "Search Table View Empty Data Set Title")
    static let CategoryListingsCollectionViewEmptyTitle = NSLocalizedString("No Listings Found", comment: "Category Listings Collection View Empty Data Set Title")
    static let SubCategoryListTableViewEmptyTitle       = NSLocalizedString("No Sub Categories Found", comment: "Sub Category Listings Collection View Empty Data Set Title")
    static let ListingDetailsTableViewEmptySubtitle     = NSLocalizedString("Select a listing to view more details", comment: "Listing Details Table View Empty Data Set Subtitle")
    
    // MARK: - Miscellaneous Copy
    static let DefaultCategoryLabel     = NSLocalizedString("Category", comment: "Default Category Label")
    static let ListingDetailsRegion     = NSLocalizedString("Region", comment: "Listing Details Region Label")
    static let ListingDetailsBuyNow     = NSLocalizedString("Buy Now", comment: "Listing Details Buy Now Label")
    static let ListingDetailsListingID  = NSLocalizedString("Listing ID", comment: "Listing Details Listing ID Label")
    static let ListingDetailsSeller     = NSLocalizedString("Seller", comment: "Listing Details Seller Label")
    
    // MARK: - Error Messages
    static let GenericErrorTitle                = NSLocalizedString("Something Went Wrong!", comment: "Generic Error Message Title")
    static let FetchCategoriesErrorTitle        = NSLocalizedString("Failed to Fetch Categories", comment: "Fetch Categories Error Title")
    static let FetchListingsErrorTitle          = NSLocalizedString("Failed to Fetch Listings", comment: "Fetch Listings Error Title")
    static let FetchListingDetailsErrorTitle    = NSLocalizedString("Failed to Fetch Listing Details", comment: "Fetch Listing Details Error Title")
    static let PleaseTryAgainLater              = NSLocalizedString("Please try again later", comment: "Please Try Again Later")
}

//
//  TradeMeAPIWrapperProtocol.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

protocol TradeMeAPIWrapperProtocol {
    
    // MARK: - API Helper Functions
    
    /// Compiles an authentication header required for authenticated request headers
    /// - Parameters:
    ///   - consumerKey: Consumer key used to to authenticate the API session
    ///   - consumerSecret: Consumer secret used to to authenticate the API session
    ///   - authMethod: Authentication method used for the API session
    func prepareAuthHeader(consumerKey: String,
                           consumerSecret: String,
                           authMethod: String) -> [String : String]
    
    // MARK: - API Endpoints
    
    /// Fetches all root categories.
    /// Documented at: http://developer.trademe.co.nz/api-reference/catalogue-methods/retrieve-general-categories
    ///
    /// - Parameter completion: Completion handler called when the request has completed
    ///
    func getRootCategories(completion: @escaping (Result<[Category], Error>) -> ())
    
    /// Fetches child categories for a given parent category
    /// Documented at: http://developer.trademe.co.nz/api-reference/catalogue-methods/retrieve-general-categories
    ///
    /// - Parameters:
    ///   - categoryNumber: The category number of the parent category to be queried
    ///   - completion: Completion handler called when the request has completed
    ///
    func expandCategory(withCategoryNumber categoryNumber: String,
                        completion: @escaping (Result<Category, Error>) -> ())
    
    /// Fetches listings associated with a given category
    /// Documented at: https://developer.trademe.co.nz/api-reference/search-methods/general-search/
    ///
    /// - Parameters:
    ///   - categoryNumber: The category number of the parent category to be queried
    ///   - page: Current page index for which listings are queried
    ///   - rows: Number of listings per page that are returned
    ///   - imageSize: Preferred lsiting image size
    ///   - completion: Completion handler called when the request has completed
    ///
    func getListings(inCategoryWithNumber categoryNumber: String,
                     page: Int,
                     rows: Int,
                     withImageSize imageSize: ImageSize,
                     completion: @escaping (Result<SearchResult, Error>) -> Void)
    
    /// Fetches detailed metadata for a given listing
    /// Documented at: https://developer.trademe.co.nz/api-reference/listing-methods/retrieve-the-details-of-a-single-listing/
    ///
    /// - Parameters:
    ///   - listingId: The listing ID for which detailed metadata is queried
    ///   - completion: Completion handler called when the request has completed
    ///
    func getDetails(forListingWithId listingId: Int,
                    completion: @escaping (Result<ListingDetail, Error>) -> Void)
}

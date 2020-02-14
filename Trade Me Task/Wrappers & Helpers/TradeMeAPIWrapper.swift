//
//  TradeMeAPIWrapper.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation
import Alamofire

struct TradeMeAPIWrapper: TradeMeAPIWrapperProtocol {
    
    // MARK: - API Helper Functions
    
    /// Compiles an authentication header required for authenticated request headers
    func prepareAuthHeader(consumerKey: String = Constants.API.Credentials.consumerKey,
                           consumerSecret: String = Constants.API.Credentials.consumerSecret,
                           authMethod: String = Constants.API.oauthMethod) -> [String : String] {

        let authValue = String(format: "OAuth oauth_consumer_key=\"%@\", oauth_signature_method=\"%@\", oauth_signature=\"%@&\"",
                               consumerKey,
                               authMethod,
                               consumerSecret)

        return ["Authorization": authValue]
    }
    
    // MARK: - API Endpoints
    
    /// Fetches all root categories.
    /// Documented at: http://developer.trademe.co.nz/api-reference/catalogue-methods/retrieve-general-categories
    ///
    /// - Parameter completion: Completion handler called when the request has completed
    ///
    func getRootCategories(completion: @escaping (Swift.Result<[Category], Error>) -> ()) {
        
        let endpointURL = "\(Constants.API.baseURL)\(Constants.API.Endpoints.getCategories)/0.json"
        let params = ["depth": 1]
        
        Alamofire.request(endpointURL, parameters: params).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let root = try JSONDecoder().decode(Category.self, from: data)
                    completion(.success(root.subCategories))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Fetches child categories for a given parent category
    /// Documented at: http://developer.trademe.co.nz/api-reference/catalogue-methods/retrieve-general-categories
    ///
    /// - Parameters:
    ///   - categoryNumber: The category number of the parent category to be queried
    ///   - completion: Completion handler called when the request has completed
    ///
    func expandCategory(withCategoryNumber categoryNumber: String,
                        completion: @escaping (Swift.Result<Category, Error>) -> ()) {
        
        let endpointURL = "\(Constants.API.baseURL)\(Constants.API.Endpoints.getCategories)/\(categoryNumber).json?with_counts=true"
        let params = ["depth": 1]
        
        Alamofire.request(endpointURL, parameters: params).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let category = try JSONDecoder().decode(Category.self, from: data)
                    completion(.success(category))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
                     completion: @escaping (Swift.Result<SearchResult, Error>) -> Void) {
        
        let endpointURL = "\(Constants.API.baseURL)\(Constants.API.Endpoints.searchGeneral).json?category=\(categoryNumber)&rows=\(rows)&page=\(page)&photo_size=Large"
        
        Alamofire.request(endpointURL, parameters: nil, headers: prepareAuthHeader()).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(.success(searchResult))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Fetches detailed metadata for a given listing
    /// Documented at: https://developer.trademe.co.nz/api-reference/listing-methods/retrieve-the-details-of-a-single-listing/
    ///
    /// - Parameters:
    ///   - listingId: The listing ID for which detailed metadata is queried
    ///   - completion: Completion handler called when the request has completed
    ///
    func getDetails(forListingWithId listingId: Int,
                    completion: @escaping (Swift.Result<ListingDetail, Error>) -> Void) {
        let endpointURL = "\(Constants.API.baseURL)\(Constants.API.Endpoints.getListing)/\(listingId).json?return_member_profile=true"
        Alamofire.request(endpointURL, headers: prepareAuthHeader()).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let listingDetail = try JSONDecoder().decode(ListingDetail.self, from: data)
                    completion(.success(listingDetail))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

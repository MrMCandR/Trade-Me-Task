//
//  CategoryListingsPresenter.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

protocol CategoryListingsPresenterDelegate: class {
    func display(listingPreviews: [ListingPreview])
    func displayDetails(forListing listing: ListingPreview)
    func updateActivityIndicator(loading: Bool)
    func display(error: Error)
}

class CategoryListingsPresenter: BasePresenter {
    
    // MARK: - Presenter Properties
    private weak var delegate: CategoryListingsPresenterDelegate?
    private let apiWrapper: TradeMeAPIWrapperProtocol
    
    private (set) var listingPreviews: [ListingPreview] = []
    
    init(delegate: CategoryListingsPresenterDelegate,
         apiWrapper: TradeMeAPIWrapperProtocol) {
        self.delegate = delegate
        self.apiWrapper = apiWrapper
    }
    
    public func viewReadyToDisplay() {}
    
    public func fetchAndDisplayListingPreviews(forCategory category: Category) {
        listingPreviews.removeAll()
        delegate?.updateActivityIndicator(loading: true)
        
        apiWrapper.getListings(inCategoryWithNumber: category.number,
                               page: 1, rows: Constants.API.defaultListingPageCount,
                               withImageSize: .large) { [weak self] (result) in
            guard let self = self else { return }
                                
            self.delegate?.updateActivityIndicator(loading: false)
            
            switch result {
            case .success(let searchResult):
                self.listingPreviews = searchResult.listings
                self.delegate?.display(listingPreviews: searchResult.listings)
            case .failure(let error):
                self.delegate?.display(error: error)
            }
        }
    }
    
    public func didSelectListingPreview(atIndex index: Int) {
        delegate?.displayDetails(forListing: listingPreviews[index])
    }
}

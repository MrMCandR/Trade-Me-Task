//
//  ListingDetailPresenter.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 14/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

protocol ListingDetailPresenterDelegate: class {
    func display(genericUIItems: [GenericUIItemModel])
    func updateActivityIndicator(loading: Bool)
    func display(error: Error)
}

class ListingDetailPresenter: BasePresenter {
    
    // MARK: - Presenter Properties
    private weak var delegate: ListingDetailPresenterDelegate?
    private let apiWrapper: TradeMeAPIWrapperProtocol
    
    private (set) var genericUIItems: [GenericUIItemModel] = []
    
    init(delegate: ListingDetailPresenterDelegate,
         apiWrapper: TradeMeAPIWrapperProtocol) {
        self.delegate = delegate
        self.apiWrapper = apiWrapper
    }
    
    public func viewReadyToDisplay() {}
    
    public func fetchAndDisplayDetails(forListingPreview listingPreview: ListingPreview) {
        delegate?.updateActivityIndicator(loading: true)
        
        apiWrapper.getDetails(forListingWithId: listingPreview.listingId) { [weak self] (result) in
            guard let self = self else { return }
            
            self.delegate?.updateActivityIndicator(loading: false)
            
            switch result {
            case .success(let listing):
                self.delegate?.display(genericUIItems: self.collateGenericUIItems(forListingDetails: listing))
            case .failure(let error) :
                self.delegate?.display(error: error)
            }
        }
    }
    
    public func collateGenericUIItems(forListingDetails listingDetails: ListingDetail) -> [GenericUIItemModel] {
        genericUIItems.removeAll()
        
        // Listing images
        let largePhotos = listingDetails.getPhotoURLs(forPhotoSize: .large)
        if !largePhotos.isEmpty {
            genericUIItems.append(ImageItemModel(withImageURLs: largePhotos))
        }
        
        // Title and price
        genericUIItems.append(KeyValueItemModel(withKey: listingDetails.title,
                                                withValue: listingDetails.priceDisplay))
        
        // Region
        genericUIItems.append(KeyValueItemModel(withKey: Strings.ListingDetailsRegion,
                                                withValue: listingDetails.region))
        
        // Buy now
        if listingDetails.hasBuyNow ?? false,
            let buyNowPrice = listingDetails.buyNowPrice {
            genericUIItems.append(KeyValueItemModel(withKey: Strings.ListingDetailsBuyNow,
                                                    withValue: "$\(buyNowPrice)"))
        }
        
        // Listing ID
        genericUIItems.append(KeyValueItemModel(withKey: Strings.ListingDetailsListingID,
                                                withValue: "\(listingDetails.listingId)"))
        
        // Member info
        if let memberInfo = listingDetails.member {
            genericUIItems.append(KeyValueItemModel(withKey: Strings.ListingDetailsSeller,
                                                    withValue: memberInfo.nickname))
        }
        
        return genericUIItems
    }
}

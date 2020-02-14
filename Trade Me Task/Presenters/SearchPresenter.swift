//
//  SearchPresenter.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

protocol SearchPresenterDelegate: class {
    func display(rootCategories: [Category])
    func updateActivityIndicator(loading: Bool)
    func display(error: Error)
    func displayListings(forCategory category: Category)
}

class SearchPresenter: BasePresenter {
    
    // MARK: - Presenter Properties
    private weak var delegate: SearchPresenterDelegate?
    private let apiWrapper: TradeMeAPIWrapperProtocol
    
    private (set) var rootCategories: [Category] = []
    
    init(delegate: SearchPresenterDelegate,
         apiWrapper: TradeMeAPIWrapperProtocol) {
        self.delegate = delegate
        self.apiWrapper = apiWrapper
    }
    
    public func viewReadyToDisplay() {
        fetchAndDisplayRootCategories()
    }
    
    public func fetchAndDisplayRootCategories() {
        delegate?.updateActivityIndicator(loading: true)
        
        apiWrapper.getRootCategories { [weak self] (result) in
            guard let self = self else { return }
            
            self.delegate?.updateActivityIndicator(loading: false)
            
            switch result {
            case .success(let rootCategories):
                self.rootCategories = rootCategories
                self.delegate?.display(rootCategories: rootCategories)
            case .failure(let error):
                self.delegate?.display(error: error)
            }
        }
    }
    
    public func didSelectCategory(atIndex index: Int) {
        delegate?.displayListings(forCategory: rootCategories[index])
    }
}

//
//  SubCategoriesListPresenter.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import Foundation

protocol CategorySelectionDelegate: class {
    func categorySelected(category: Category)
}

protocol SubCategoriesListPresenterDelegate: class {
    func display(category: Category)
    func present(subCategory: Category, categorySelectionDelegate: CategorySelectionDelegate?)
    func updateActivityIndicator(loading: Bool)
    func display(error: Error)
    func shouldDismiss()
}

class SubCategoriesListPresenter: BasePresenter {
    
    // MARK: - Presenter Properties
    private weak var delegate: SubCategoriesListPresenterDelegate?
    private weak var categorySelectionDelegate: CategorySelectionDelegate?
    private let apiWrapper: TradeMeAPIWrapperProtocol
    
    private (set) var selectedCategoryNumber: String?
    private (set) var loadedCategory: Category?
    
    init(delegate: SubCategoriesListPresenterDelegate,
         apiWrapper: TradeMeAPIWrapperProtocol) {
        self.delegate = delegate
        self.apiWrapper = apiWrapper
    }
    
    public func viewReadyToDisplay() {
        if let previouslySelectedCategory = loadedCategory {
            categorySelectionDelegate?.categorySelected(category: previouslySelectedCategory)
        } else if let selectedCategoryNumber = selectedCategoryNumber {
            fetchAndDisplaySubCategories(forCategoryWithNumber: selectedCategoryNumber)
        }
    }
    
    public func loadCategory(categoryNumber: String,
                             categorySelectionDelegate: CategorySelectionDelegate? = nil) {
        selectedCategoryNumber = categoryNumber
        self.categorySelectionDelegate = categorySelectionDelegate
    }
    
    public func fetchAndDisplaySubCategories(forCategoryWithNumber categoryNumber: String) {
        delegate?.updateActivityIndicator(loading: true)
        
        apiWrapper.expandCategory(withCategoryNumber: categoryNumber) { [weak self] (result) in
            guard let self = self else { return }
            
            self.delegate?.updateActivityIndicator(loading: false)
            
            switch result {
            case .success(let category):
                self.loadedCategory = category
                self.delegate?.display(category: category)
            case .failure(let error):
                self.delegate?.display(error: error)
            }
        }
    }
    
    public func didSelectSubCategory(atIndex index: Int) {
        if let selectedSubCategory = loadedCategory?.subCategories[index] {
            categorySelectionDelegate?.categorySelected(category: selectedSubCategory)
            
            // If this category is a leaf, there are no further sub categories to display
            if selectedSubCategory.isLeaf {
                delegate?.shouldDismiss()
            } else {
                delegate?.present(subCategory: selectedSubCategory,
                                  categorySelectionDelegate: categorySelectionDelegate)
            }
        }
    }
}

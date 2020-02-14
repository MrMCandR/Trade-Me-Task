//
//  CategoryListingsCollectionViewController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import PKHUD

class CategoryListingsCollectionViewController: BaseCollectionViewController {
    
    // MARK: - Interface Builder Components
    private var categoriesButton = UIBarButtonItem()
    
    // MARK: - Logic Properties
    private lazy var presenter: CategoryListingsPresenter = {
        return CategoryListingsPresenter(delegate: self,
                                         apiWrapper: TradeMeAPIWrapper())
    }()
    
    private weak var detailSelectionDelegate: DetailSelectionDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionViewLayout.invalidateLayout()
        presenter.viewReadyToDisplay()
    }
    
    public func configure(withCategory category: Category,
                          withDetailSelectionDelegate detailSelectionDelegate: DetailSelectionDelegate? = nil) {
        title = category.name
        presenter.fetchAndDisplayListingPreviews(forCategory: category)
        
        if let selectionDelegate = detailSelectionDelegate {
            self.detailSelectionDelegate = selectionDelegate
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setupNaviagtionItems()
        emptyDataSetTitle = Strings.CategoryListingsCollectionViewEmptyTitle
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        register(nibs: ListingPreviewCollectionViewCell.self)
        collectionView!.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    private func setupNaviagtionItems() {
        categoriesButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(categoriesButtonTapped))
        navigationItem.rightBarButtonItem = categoriesButton
    }
    
    @objc private func categoriesButtonTapped() {
        let subCategoriesNavVC: BaseNavigationController = StoryboardHelper.Storyboard.categories.instantiateViewController()
        subCategoriesNavVC.loadInitialCategorySelection(withCategorySelectionDelegate: self)
        
        subCategoriesNavVC.modalPresentationStyle = .popover
        subCategoriesNavVC.preferredContentSize = CGSize(width: 320, height: 500)
        
        if let popoverPresentationViewController = subCategoriesNavVC.popoverPresentationController {
            popoverPresentationViewController.delegate = self
            popoverPresentationViewController.permittedArrowDirections = .up
            popoverPresentationViewController.barButtonItem = categoriesButton
            
            self.present(subCategoriesNavVC, animated: true, completion: nil)
        }
    }
}

// MARK: - Presenter Extensions
extension CategoryListingsCollectionViewController: CategoryListingsPresenterDelegate {
    func display(listingPreviews: [ListingPreview]) {
        collectionView.reloadData()
        collectionView.reloadEmptyDataSet()
    }
    
    func updateActivityIndicator(loading: Bool) {
        if loading {
            HUD.show(.progress, onView: view)
        } else {
            HUD.hide()
        }
    }
    
    func display(error: Error) {
        let errorContent = HUDContentType.labeledImage(image: Utils.errorKevin(),
                                                       title: Strings.FetchListingsErrorTitle,
                                                       subtitle: Strings.PleaseTryAgainLater)
        HUD.flash(errorContent, onView: view, delay: Constants.UI.errorDisplayDuration)
    }
    
    func displayDetails(forListing listing: ListingPreview) {
        detailSelectionDelegate?.shouldDisplayDetails(forListing: listing)
    }
}

// MARK: - Category selection (via popover) delegate

extension CategoryListingsCollectionViewController: CategorySelectionDelegate {
    func categorySelected(category: Category) {
        configure(withCategory: category)
    }
}

// MARK: - Collection View Controller Extensions
extension CategoryListingsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return presenter.listingPreviews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingPreviewCollectionViewCell.reuseId, for: indexPath) as! ListingPreviewCollectionViewCell
        cell.configure(withListingPreview: presenter.listingPreviews[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectListingPreview(atIndex: indexPath.row)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ListingPreviewCollectionViewCell {
            cell.tapAnimation()
        }
    }
}

// MARK: - UICollectionView flow layout delegate
extension CategoryListingsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.size.width
        let preferredMultiColumnCount: CGFloat = 2
        let padding: CGFloat = 16
        
        // Optimised for wide collection view configuration
        if collectionViewWidth >= Constants.UI.doubleColumnWidthRequirement {
            let doubleColumnCellSize = (collectionViewWidth - (2 * padding)) / preferredMultiColumnCount
            return CGSize(width: doubleColumnCellSize, height: doubleColumnCellSize)
            
            // Optimised for narrow collection view configuration
        } else {
            let singleColumnCellSize = collectionViewWidth - (2 * padding)
            return CGSize(width: singleColumnCellSize, height: singleColumnCellSize)
        }
    }
}

extension CategoryListingsCollectionViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - Storyboard Helper Extensions
extension CategoryListingsCollectionViewController: StoryboardFactoryInstantiatable {
    static var storyboardId: String {
        String(describing: self)
    }
}

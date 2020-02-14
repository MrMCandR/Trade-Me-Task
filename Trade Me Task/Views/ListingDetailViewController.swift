//
//  ListingDetailViewController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import PKHUD

class ListingDetailViewController: BaseTableViewController {
    
    // MARK: - Logic Properties
    private lazy var presenter: ListingDetailPresenter = {
        return ListingDetailPresenter(delegate: self,
                                      apiWrapper: TradeMeAPIWrapper())
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewReadyToDisplay()
    }
    
    public func configure(withListingPreview listingPreview: ListingPreview) {
        title = listingPreview.title
        presenter.fetchAndDisplayDetails(forListingPreview: listingPreview)
    }
    
    override func setupUI() {
        super.setupUI()
        
        emptyDataSetSubtitle = Strings.ListingDetailsTableViewEmptySubtitle
        disableLargeStyleNavigationBar()
    }
    
    override func setupTableView() {
        super.setupTableView()
        register(nibs: ImageCell.self, KeyValueCell.self)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Presenter Extensions
extension ListingDetailViewController: ListingDetailPresenterDelegate {
    func display(genericUIItems: [GenericUIItemModel]) {
        tableView.reloadData()
        tableView.reloadEmptyDataSet()
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
                                                       title: Strings.FetchListingDetailsErrorTitle,
                                                       subtitle: Strings.PleaseTryAgainLater)
        HUD.flash(errorContent, onView: view, delay: Constants.UI.errorDisplayDuration)
    }
}

// MARK: - Table View Controller Extensions
extension ListingDetailViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return presenter.genericUIItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genericItem = presenter.genericUIItems[indexPath.row]
        
        switch genericItem {
            
        case let imageItem as ImageItemModel:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseId) as! ImageCell
            imageCell.configure(withImageItem: imageItem)
            return imageCell
            
        case let keyValueItem as KeyValueItemModel:
            let keyValueCell = tableView.dequeueReusableCell(withIdentifier: KeyValueCell.reuseId) as! KeyValueCell
            keyValueCell.configure(withKeyValueItem: keyValueItem)
            return keyValueCell
            
        default:
            assert(false, "ListingDetailViewController: Invalid generic setting view model: \(genericItem)")
        }
    }
}

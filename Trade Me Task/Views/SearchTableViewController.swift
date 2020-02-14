//
//  SearchTableViewController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import PKHUD

class SearchTableViewController: BaseTableViewController {

    // MARK: - Logic Properties
    private lazy var presenter: SearchPresenter = {
        return SearchPresenter(delegate: self,
                               apiWrapper: TradeMeAPIWrapper())
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewReadyToDisplay()
    }
    
    override func setupUI() {
        super.setupUI()
        
        title = Strings.SearchTableViewTitle
        emptyDataSetTitle = Strings.SearchTableViewEmptyTitle
        
        configureLargeStyleNavigationBar()
    }
    
    override func setupTableView() {
        super.setupTableView()
        register(nibs: CategoryCell.self)
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Presenter Extensions
extension SearchTableViewController: SearchPresenterDelegate {
    func display(rootCategories: [Category]) {
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
                                                       title: Strings.FetchCategoriesErrorTitle,
                                                       subtitle: Strings.PleaseTryAgainLater)
        HUD.flash(errorContent, onView: view, delay: Constants.UI.errorDisplayDuration)
    }
    
    func displayListings(forCategory category: Category) {
        let categoryListingsVC: CategoryListingsCollectionViewController
            = StoryboardHelper.Storyboard.categories.instantiateViewController()
        
        categoryListingsVC.configure(withCategory: category,
                                     withDetailSelectionDelegate: splitViewController as? BaseSplitViewController)
        navigationController?.pushViewController(categoryListingsVC, animated: true)
    }
}

// MARK: - Table View Controller Extensions
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return presenter.rootCategories.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseId) as! CategoryCell
        cell.configure(withCategory: presenter.rootCategories[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectCategory(atIndex: indexPath.row)
    }
}

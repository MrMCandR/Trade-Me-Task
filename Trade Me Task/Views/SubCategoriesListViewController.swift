//
//  SubCategoriesListViewController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import PKHUD

class SubCategoriesListViewController: BaseTableViewController {
    
    // MARK: - Logic Properties
    private lazy var presenter: SubCategoriesListPresenter = {
        return SubCategoriesListPresenter(delegate: self,
                                          apiWrapper: TradeMeAPIWrapper())
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewReadyToDisplay()
    }
    
    public func configure(withCategory category: Category,
                          withCategorySelectionDelegate delegate: CategorySelectionDelegate? = nil) {
        title = category.name
        presenter.loadCategory(categoryNumber: category.number, categorySelectionDelegate: delegate)
    }
    
    public func configure(withCategoryNumber categoryNumber: String,
                          withCategorySelectionDelegate delegate: CategorySelectionDelegate? = nil) {
        title = Strings.DefaultCategoryLabel
        presenter.loadCategory(categoryNumber: categoryNumber, categorySelectionDelegate: delegate)
    }
    
    override func setupUI() {
        super.setupUI()
        
        emptyDataSetTitle = Strings.SubCategoryListTableViewEmptyTitle
    }
    
    override func setupTableView() {
        super.setupTableView()
        register(nibs: CategoryCell.self)
    }
}

// MARK: - Presenter Extensions
extension SubCategoriesListViewController: SubCategoriesListPresenterDelegate {
    func display(category: Category) {
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
                                                       title: Strings.FetchListingsErrorTitle,
                                                       subtitle: Strings.PleaseTryAgainLater)
        HUD.flash(errorContent, onView: view, delay: Constants.UI.errorDisplayDuration)
    }
    
    func present(subCategory: Category, categorySelectionDelegate: CategorySelectionDelegate?) {
        let subCategoryVC: SubCategoriesListViewController = StoryboardHelper.Storyboard.categories.instantiateViewController()
        subCategoryVC.configure(withCategory: subCategory, withCategorySelectionDelegate: categorySelectionDelegate)
        navigationController?.pushViewController(subCategoryVC, animated: true)
    }
    
    func shouldDismiss() {
        dismiss(animated: true)
    }
}

// MARK: - Table View Controller Extensions
extension SubCategoriesListViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return presenter.loadedCategory?.subCategories.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseId) as! CategoryCell
        cell.configure(withCategory: presenter.loadedCategory!.subCategories[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectSubCategory(atIndex: indexPath.row)
    }
}

// MARK: - Storyboard Helper Extensions
extension SubCategoriesListViewController: StoryboardFactoryInstantiatable {
    static var storyboardId: String {
        String(describing: self)
    }
}

//
//  BaseTableViewController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import Foundation
import DZNEmptyDataSet

class BaseTableViewController: UITableViewController {
    
    public var emptyDataSetTitle = Strings.DefaultEmptyDataSetTitle
    public var emptyDataSetSubtitle = Strings.PleaseTryAgainLater
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    internal func setupUI() {
        tableView.backgroundColor = Constants.Colors.offWhite
    }
    
    internal func setupTableView() {
        tableView.emptyDataSetSource = self
    }
    
    internal func configureLargeStyleNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    internal func disableLargeStyleNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    internal func register(nibs: NibInstantiatable.Type...) {
        nibs.forEach { (nib) in
            tableView.register(nib.getNib(), forCellReuseIdentifier: nib.reuseId)
        }
    }
}

// MARK: - DZNEmptyContent Extensions
extension BaseTableViewController: DZNEmptyDataSetSource {

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return Utils.randomKevin()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle, attributes: [
            .font: Constants.Fonts.SF.bold.withSize(Constants.Fonts.emptyContentTitleSize),
            .foregroundColor: UIColor.darkGray
            ]
        )
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetSubtitle, attributes: [
            .font: Constants.Fonts.SF.medium.withSize(Constants.Fonts.emptyContentDescriptionSize),
            .foregroundColor: UIColor.lightGray
            ]
        )
    }
}

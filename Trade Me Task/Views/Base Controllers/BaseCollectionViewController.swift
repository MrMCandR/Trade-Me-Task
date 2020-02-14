//
//  BaseCollectionViewController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BaseCollectionViewController: UICollectionViewController {
    
    public var emptyDataSetTitle = Strings.DefaultEmptyDataSetTitle
    public var emptyDataSetSubtitle = Strings.PleaseTryAgainLater
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    internal func setupUI() {
        collectionView.backgroundColor = Constants.Colors.offWhite
    }
    
    internal func setupCollectionView() {
        collectionView.emptyDataSetSource = self
    }
    
    internal func configureLargeStyleNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    internal func register<T: NibInstantiatable>(nibs: T.Type...) {
        nibs.forEach { (nib) in
            collectionView.register(nib.getNib(), forCellWithReuseIdentifier: nib.reuseId)
        }
    }
}

// MARK: - DZNEmptyContent Extensions
extension BaseCollectionViewController: DZNEmptyDataSetSource {

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

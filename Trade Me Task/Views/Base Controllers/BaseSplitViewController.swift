//
//  BaseSplitViewController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

protocol DetailSelectionDelegate: class {
    func shouldDisplayDetails(forListing listing: ListingPreview)
}

class BaseSplitViewController: UISplitViewController {
    
    public var detail: ListingDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .allVisible
        delegate = self
        
        // Maintain a reference to the listing detail VC for later delegation
        if let detail = detailViewController as? ListingDetailViewController {
            self.detail = detail
        }
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Constants.Colors.offWhite
    }
}

extension BaseSplitViewController: DetailSelectionDelegate {
    func shouldDisplayDetails(forListing listing: ListingPreview) {
        detail?.configure(withListingPreview: listing)
        
        if let detailNavController = detail?.navigationController {
            showDetailViewController(detailNavController, sender: nil)
        }
    }
}


// MARK: - SplitView delegate extension
extension BaseSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension BaseSplitViewController {
    convenience init(masterViewController: UIViewController, detailViewController: UIViewController) {
        self.init()
        viewControllers = [masterViewController, detailViewController]
    }
    
    var masterViewController: UIViewController? {
        return viewControllers.first
    }
    
    var detailViewController: UIViewController? {
        guard viewControllers.count == 2 else { return nil }
        if let detailNavVC = viewControllers.last as? UINavigationController {
            return detailNavVC.viewControllers.first
        }
        return viewControllers.last
    }
}

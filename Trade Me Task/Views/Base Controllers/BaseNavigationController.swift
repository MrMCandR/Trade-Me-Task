//
//  BaseNavigationController.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    func loadInitialCategorySelection(withCategorySelectionDelegate delegate: CategorySelectionDelegate) {
        if let rootSubCategoryVC = viewControllers.first as? SubCategoriesListViewController {
            rootSubCategoryVC.configure(withCategoryNumber: Constants.Data.rootCategoryNumber, withCategorySelectionDelegate: delegate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseNavigationController: StoryboardFactoryInstantiatable {
    static var storyboardId: String {
        String(describing: self)
    }
}

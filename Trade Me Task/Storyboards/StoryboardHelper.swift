//
//  StoryboardHelper.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

protocol StoryboardFactoryInstantiatable {
    static var storyboardId: String { get }
}

protocol NibInstantiatable {
    static var reuseId: String { get }
    static func getNib() -> UINib
}

struct StoryboardHelper {
    
    /// Core Storyboard Enumeration
    ///
    /// Dedicated enumeration of each supported storyboard file,
    /// with storyboard access functions
    public enum Storyboard: String {
    
        case main = "Main"
        case categories = "Categories"
        
        /// Instantiates a required View Controller from the current Storyboard
        ///
        /// - Returns: an instance of the requested View Controller
        func instantiateViewController<T>() -> T where T : StoryboardFactoryInstantiatable {
            let storyboard = UIStoryboard(name: rawValue, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: T.storyboardId) as! T
        }
        
        /// Instantiates a required Navigation Controller from a given Storyboard
        ///
        /// - Parameters:
        ///   - identifier: identifier of the Navigation Controller to instantiate
        ///   - storyboard: storyboard from-which the Naviagtion Controller is resolved
        /// - Returns: an instance of the requested Navigation Controller
        func instantiateNavigationController(withIdentifier identifier: String) -> UINavigationController {
            let storyboard = UIStoryboard(name: rawValue, bundle: nil)
            guard let navController = storyboard.instantiateViewController(withIdentifier: identifier) as? UINavigationController else {
                fatalError("StoryboardFactory: Failed to instantiate Navigation Controller: \(rawValue)")
            }
            return navController
        }
    }
}

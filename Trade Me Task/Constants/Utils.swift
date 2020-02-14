//
//  Utils.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 13/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

struct Utils {
    static func randomKevin() -> UIImage {
        return [#imageLiteral(resourceName: "marx"), #imageLiteral(resourceName: "nietzsche"), #imageLiteral(resourceName: "aristotle"), #imageLiteral(resourceName: "locke"), #imageLiteral(resourceName: "hobbes"), #imageLiteral(resourceName: "plato"), #imageLiteral(resourceName: "descartes"), #imageLiteral(resourceName: "bernie"), #imageLiteral(resourceName: "aquinas")].randomElement() ?? #imageLiteral(resourceName: "bernie")
    }
    
    static func errorKevin() -> UIImage {
        return #imageLiteral(resourceName: "marx")
    }
    
    static func getIcon(forCategoryName categoryName: String) -> UIImage? {
        switch categoryName {
        case "Trade Me Motors":
            return UIImage(systemName: "car")
        case "Trade Me Property":
            return UIImage(systemName: "house")
        case "Trade Me Jobs":
            return UIImage(systemName: "briefcase")
        case "Antiques & collectables":
            return UIImage(systemName: "hourglass")
        case "Art":
            return UIImage(systemName: "photo")
        case "Baby gear":
            return UIImage(systemName: "scribble")
        case "Books":
            return UIImage(systemName: "book")
        case "Building & renovation":
            return UIImage(systemName: "hammer")
        case "Business, farming & industry":
            return UIImage(systemName: "chart.pie")
        case "Clothing & Fashion":
            return UIImage(systemName: "person")
        case "Computers":
            return UIImage(systemName: "desktopcomputer")
        case "Crafts":
            return UIImage(systemName: "pencil.and.outline")
        case "Electronics & photography":
            return UIImage(systemName: "camera")
        case "Flatmates wanted":
            return UIImage(systemName: "person.3")
        case "Gaming":
            return UIImage(systemName: "gamecontroller")
        case "Health & beauty":
            return UIImage(systemName: "heart")
        case "Home & living":
            return UIImage(systemName: "house")
        case "Jewellery & watches":
            return UIImage(systemName: "stopwatch")
        case "Mobile phones":
            return UIImage(systemName: "phone")
        case "Movies & TV":
            return UIImage(systemName: "film")
        case "Music & instruments":
            return UIImage(systemName: "music.mic")
        case "Pets & animals":
            return UIImage(systemName: "hare")
        case "Pottery & glass":
            return UIImage(systemName: "archivebox.fill")
        case "Services":
            return UIImage(systemName: "chart.bar")
        case "Sports":
            return UIImage(systemName: "sportscourt")
        case "Toys & models":
            return UIImage(systemName: "cube")
        case "Travel, events & activities":
            return UIImage(systemName: "airplane")
        default:
            return nil
        }
    }
}

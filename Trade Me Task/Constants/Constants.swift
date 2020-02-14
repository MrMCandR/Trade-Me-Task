//
//  Constants.swift
//  Trade Me Task
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import UIKit

struct Constants {
    
    struct UI {
        static let defaultCornerRadius: CGFloat   = 12.0
        static let mediumCornerRadius: CGFloat    = 20.0
        static let defaultIconSize: CGSize        = CGSize(width: 30, height: 30)
        static let doubleColumnWidthRequirement: CGFloat = 568.0
        static let emptyContentImageSize: CGSize  = CGSize(width: 60, height: 60)
        static let errorDisplayDuration: TimeInterval = 3
    }
    
    struct Animation {
        static let scaleAnimationDuration: Double = 0.1
    }
    
    struct Colors {
        // Trade Me branding color palette
        static let tmYellow     = UIColor(red:0.98, green:0.76, blue:0.22, alpha:1.0)
        static let tmBlue       = UIColor(red:0.18, green:0.56, blue:0.89, alpha:1.0)
        static let tmBrown      = UIColor(red:0.50, green:0.16, blue:0.01, alpha:1.0)
        static let tmDarkBrown  = UIColor(red:0.27, green:0.24, blue:0.17, alpha:1.0)
        static let tmBlack      = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
        
        // Standard color palette
        static let offWhite         = UIColor.systemGroupedBackground
        static let extraLightGray   = UIColor(white: 0.9, alpha: 1.0)
        static let darkGray         = UIColor.darkGray
    }
    
    struct Fonts {
        struct SF {
            static let ultraLight = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.ultraLight)
            static let thin       = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.thin)
            static let regular    = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
            static let medium     = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
            static let semiBold   = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
            static let bold       = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            static let heavy      = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
            static let black      = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.black)
        }
        
        static let emptyContentTitleSize: CGFloat = 25
        static let emptyContentDescriptionSize: CGFloat = 18
    }
    
    struct API {
        static let baseURL     = "https://api.tmsandbox.co.nz/v1"
        static let oauthMethod = "PLAINTEXT"
        
        static let defaultListingPageCount = 20
        
        struct Credentials {
            static let consumerKey    = "A1AC63F0332A131A78FAC304D007E7D1"
            static let consumerSecret = "EC7F18B17A062962C6930A8AE88B16C7"
        }
        
        struct Endpoints {
            static let getCategories  = "/Categories"
            static let searchGeneral  = "/Search/General"
            static let getListing     = "/Listings"
        }
    }
    
    struct Data {
        static let rootCategoryNumber = "0-"
    }
    
    struct Storyboards {
        static let main = UIStoryboard(name: "Main", bundle: nil)
        static let subCategories = UIStoryboard(name: "SubCategories", bundle: nil)
    }
}

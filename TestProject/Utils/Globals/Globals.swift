//
//  Globals.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit

//MARK: GENERAL
let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let APP_NAME = "Test Project"

//MARK: YELP KEYS
struct YelpKeys {
    static let YelpAppId = "ya80YcNGzWH3zR6j4QezBA"
    static let YelpAppSecretKey = "3FEvdilwCSpm0opqrcnhvmxtM1LnGZVZBzWUAzFu65no8hxiUHifOsAJ8emPUOMv"
    static let YelpConsumerKey = "-_aCFGTXNrALziqFobXipA"
    static let YelpConsumerSecret = "fffQpImOcJEOJvFiOtwgfrMC6f0"
    static let YelpToken = "r93XRyXhbph9gteXcWSnK47qTwZAsO_H"
    static let YelpTokenSecret = "Mnca05Icgf6gG1m51KoCQUM0rwY"
}

//MARK: MESSAGES
struct Message {
    static let AppName = APP_NAME
    static let locatonServiceMessage = "You will be now transferred to the APP SETTINGS - please select PRIVACY/LOCATION and enable 'while using app'"
    static let locationEnableMessage = "Your location services are DISABLED. Would you like to enable it for a better user experience?"
    static let internetConnectionMessage = "Please check your internet connection and try again."
    static let failedToInitiateYelp = "Unable to initialize Yelp. Please try again."
    static let noCategoriesAvailable = "No Categories Available"
    static let notAvailable = "N/A"
}

//MARK: SCREEN TITLES
struct Titles {
    static let TitleHomeScreen = "Home"
}

//MARK: SEGUE NAMES
struct Segue {
    static let ToBusinessDetailsScreen = "toBusinessDetailsScreen"
}

//MARK: CELL IDENTIFIERS
struct CellIdentifiers {
    static let BusinessImageCell = "BusinessImageCell"
    static let BasicInfoCell = "DefaultCell"
}

//MARK : HEADER VIEWS
struct HeaderView {
    static let BaseHeaderView = "BaseHeaderView"
}

//MARK: ALERT BUTTONS
struct AlertButtons {
    static let tCancel = "Cancel"
    static let tOK = "OK"
}

//MARK: ALERT ATTRIBUTS
struct AlertAttributes {
    static let titleTextColor = "titleTextColor"
    static let attributedTitle = "attributedTitle"
    static let attributedMessage = "attributedMessage"
}

//MARK: BUSINESS DETAILS TITLES
struct BusinessDetailTitles {
    static let image = "Image"
    static let basicInfo = "Basic Info"
    static let categories = "Categories"
    static let rating = "Rating: "
    static let reviewCount = "Review Count: "
    static let address = "Address: "
    static let phone = "Phone: "
}


// MARK: DEVICE & SCREEN SIZE CONSTANTS
let IS_IPHONE4  = fabs(UIScreen.main.bounds.size.height - 480) < 1;
let IS_IPHONE5  = fabs(UIScreen.main.bounds.size.height - 568) < 1;
let IS_IPHONE6  = fabs(UIScreen.main.bounds.size.height - 667) < 1;
let IS_IPHONE6P = fabs(UIScreen.main.bounds.size.height - 736) < 1;

// MARK: - INTERNET CHECK
func IS_INTERNET_AVAILABLE() -> Bool{
    return ReachabilityManager.shared.isInternetAvailableForAllNetworks()
}

// MARK: DEVICE & SCREEN SIZE CONSTANTS
let SCREEN_WIDTH  = (UIScreen.main.bounds.size.width)
let SCREEN_HEIGHT  = (UIScreen.main.bounds.size.height)


// MARK: COMMON FUNCTIONS
func proportionalFontSize(size:CGFloat) -> CGFloat {
    return (size + (IS_IPHONE6P ? 0 : 0) + (IS_IPHONE6 ? -1 : 0) + (IS_IPHONE5 ? -2 : 0) + (IS_IPHONE4 ? -3 : 0))
}

func getProportionalHeight(height: CGFloat) -> CGFloat
{
    return CGFloat(Int((SCREEN_HEIGHT * height)/667))
}

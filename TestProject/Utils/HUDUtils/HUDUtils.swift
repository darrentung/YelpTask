//
//  AppDelegate.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import UIKit
import SVProgressHUD

class HUDUtils: NSObject {

    //MARK:- CUSTOM LOADER
    class func showCustomLoader(){
        appDelegate.window?.endEditing(true)
        SVProgressHUD.setFont(UIFont.regularFontOfSize(size: 16.0))
        SVProgressHUD.setForegroundColor(UIColor.themeColor)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: "Please wait...")
        UIApplication.shared.isNetworkActivityIndicatorVisible =  true
    }
    
    class func hideCustomLoader(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            UIApplication.shared.isNetworkActivityIndicatorVisible =  false
        }
    }
}

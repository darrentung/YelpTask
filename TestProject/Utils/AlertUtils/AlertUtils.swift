//
//  AppDelegate.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import UIKit


class AlertUtils: NSObject {

    // MARK: - ALERT
    class func displayNoInternetMessage() {
        displayAlertWithMessage(message: Message.internetConnectionMessage, cancelButtonTitle: AlertButtons.tCancel, buttons:[], completion: nil)
    }

    class func displayAlertWithMessage(message:String) -> Void {
        displayAlertWithMessage(message: message,cancelButtonTitle:  AlertButtons.tCancel, buttons: [], completion: nil)
    }

    class func displayAlertWithMessage(message:String, cancelButtonTitle : String) -> Void {
        displayAlertWithMessage(message: message, cancelButtonTitle: cancelButtonTitle, buttons: [], completion: nil)
    }

    
    class func displayAlertWithMessage(message:String, cancelButtonTitle : String, buttons:[String], completion:((_ index:Int)  -> Void)?) {
        
        let alertController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        for index in 0..<buttons.count	{

            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion!(index)
                }
            })
            
            action.setValue(UIColor.darkGray, forKey: AlertAttributes.titleTextColor)
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.themeColor, forKey: AlertAttributes.titleTextColor)
        alertController.addAction(cancelAction)

        alertController.setValue(NSAttributedString(string: APP_NAME, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: UIFont.systemFontSize), NSAttributedStringKey.foregroundColor : UIColor.darkGray]), forKey: AlertAttributes.attributedTitle)
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: UIFont.systemFontSize), NSAttributedStringKey.foregroundColor : UIColor.gray]), forKey: AlertAttributes.attributedMessage)

        appDelegate.window?.rootViewController!.present(alertController, animated: true, completion:nil)
    }
    

    
    class func displayAlertWithTitle(title:String, andMessage message:String, buttons:[String], completion:((_ index:Int)  -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: UIFont.systemFontSize), NSAttributedStringKey.foregroundColor : UIColor.darkGray]), forKey: AlertAttributes.attributedTitle)
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: UIFont.systemFontSize), NSAttributedStringKey.foregroundColor : UIColor.darkGray]), forKey: AlertAttributes.attributedMessage)

        for index in 0..<buttons.count	{
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion!(index)
                }
            })
            
            action.setValue(UIColor.themeColor, forKey: AlertAttributes.titleTextColor)
            alertController.addAction(action)
        }
        

        appDelegate.window?.rootViewController!.present(alertController, animated: true, completion:nil)
    }
    
}

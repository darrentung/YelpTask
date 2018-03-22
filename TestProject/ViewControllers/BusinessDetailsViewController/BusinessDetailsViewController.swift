//
//  BusinessDetailsViewController.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

class BusinessDetailsViewController: BaseViewController {

    //MARK: OUTLETS
    @IBOutlet weak var tableViewBusinessDetails: BusinessDetailsTableView!
    
    //MARK: VARIABLES
    var businessToDisplay : Business?
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        self.title = self.businessToDisplay?.businessName
        self.tableViewBusinessDetails.businessToDisplayDetails = self.businessToDisplay
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

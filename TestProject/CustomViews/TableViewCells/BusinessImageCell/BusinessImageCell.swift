//
//  BusinessImageCell.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

class BusinessImageCell: BaseTableViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var imageViewBusiness: UIImageView!
    @IBOutlet weak var labelBusinessName: LabelBold!
    
    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        self.labelBusinessName.text = ""
    }
    
    //MARK:- UPDATE DETAILS
    func loadImage(forBusiness business: Business) {
        
        // BUSINESS NAME
        self.labelBusinessName.text = business.businessName
        
        // BUSINESS IMAGE
        guard business.businessImageURL != nil else {
            return
        }
        self.imageViewBusiness.loadImage(from: URL(string: business.businessImageURL!)!, placeHolderImage: #imageLiteral(resourceName: "restaurantPlaceholder"))
    }
}

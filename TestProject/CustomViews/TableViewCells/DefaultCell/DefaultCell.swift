//
//  DefaultCell.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

class DefaultCell: BaseTableViewCell {
    @IBOutlet weak var labelTitle: LabelRegular!
    
    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelTitle.text = ""
    }
}

//
//  BaseTableView.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit

class BaseTableView: UITableView {
    
    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableFooterView = UIView()
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.separatorStyle = .none
    }
    
}

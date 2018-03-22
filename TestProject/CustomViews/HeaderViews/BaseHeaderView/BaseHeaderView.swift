//
//  BaseHeaderView.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class BaseHeaderView: UIView {
    
    //MARK: OUTLETS
    @IBOutlet weak var labelTitle: LabelBold!
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var viewBottomLine: UIView!

    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CONFIGURATION
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed(HeaderView.BaseHeaderView, owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.autoPinEdgesToSuperviewEdges()
    }
    
    //MARK:- UPDATE DETAILS
    func setup(withTitle title : String) {
        self.labelTitle.text = title
    }
    

}



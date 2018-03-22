//
//  BusinessDetailsTableView.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

class BusinessDetailsTableView: BaseTableView {
    
    //MARK: VARIABLES
    var arraySectionTitles = [BusinessDetailTitles.image,BusinessDetailTitles.basicInfo,BusinessDetailTitles.categories]
    var arrayBasicInfo : [String] = []
    var businessToDisplayDetails : Business? {
        didSet {
            arrayBasicInfo = ["\(BusinessDetailTitles.rating)\(String(format: "%g",(self.businessToDisplayDetails?.businessRating)!))",
                "\(BusinessDetailTitles.reviewCount)\(String(format: "%d",(self.businessToDisplayDetails?.businessReviewsCount)!))",
                "\(BusinessDetailTitles.address)\(self.businessToDisplayDetails?.businessAddress ?? Message.notAvailable))",
                "\(BusinessDetailTitles.phone)\(self.businessToDisplayDetails?.businessPhone ?? Message.notAvailable)"]
            self.reloadData()
        }
    }
    
    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.register(UINib(nibName: CellIdentifiers.BusinessImageCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.BusinessImageCell)
        self.register(UINib(nibName: CellIdentifiers.BasicInfoCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.BasicInfoCell)

        self.dataSource = self
        self.delegate = self
    }
    
}

//MARK: UITableViewDataSource METHODS
extension BusinessDetailsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard self.businessToDisplayDetails != nil else {
            return 0
        }
        
        switch section {
            // IMAGE SECTION
        case BusinessDetailsCellTypes.Image.rawValue:
            return 1
            
            // BASIC INFO SECTION
        case BusinessDetailsCellTypes.Basic.rawValue:
            return arrayBasicInfo.count
            
            // CATEGORIES SECTION
        case BusinessDetailsCellTypes.Categories.rawValue:
            return self.businessToDisplayDetails!.categories!.count > 0 ? self.businessToDisplayDetails!.categories!.count : 1
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
            // IMAGE CELL
        case BusinessDetailsCellTypes.Image.rawValue:
            let imageCell : BusinessImageCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.BusinessImageCell) as! BusinessImageCell
            imageCell.loadImage(forBusiness: self.businessToDisplayDetails!)
            return imageCell
            
            // BASIC INFO
        case BusinessDetailsCellTypes.Basic.rawValue:
            let basicInfoCell : DefaultCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.BasicInfoCell) as! DefaultCell
            basicInfoCell.labelTitle.text = arrayBasicInfo[indexPath.row]
            return basicInfoCell

            // CATEGORIES
        case BusinessDetailsCellTypes.Categories.rawValue:
            let basicInfoCell : DefaultCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.BasicInfoCell) as! DefaultCell
            
            if self.businessToDisplayDetails!.categories!.count > 0 {
                let category = self.businessToDisplayDetails!.categories!.allObjects[indexPath.row] as! Category
                basicInfoCell.labelTitle.text = category.catgoryName
            }
            else{
                basicInfoCell.labelTitle.text = Message.noCategoriesAvailable
            }
            
            return basicInfoCell

            // DEFAULT
        default:
            return UITableViewCell()
        }
        
    }

}

//MARK: UITableViewDelegate METHODS
extension BusinessDetailsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getProportionalHeight(height: 50.0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = BaseHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:  getProportionalHeight(height: 40.0)))
        headerView.viewBottomLine.isHidden = true
        headerView.labelTitle.text = arraySectionTitles[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.estimatedRowHeight = 200.0
        return UITableViewAutomaticDimension
    }

    

}

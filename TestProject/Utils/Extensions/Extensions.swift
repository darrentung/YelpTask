//
//  Extensions.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import MapKit

// MARK: String EXTENTSION
extension String {
    
    // Get TextLength
    var textlength: Int {
        get {
            return (self as NSString).length
        }
    }
}

// MARK: UIFont EXTENTSION
extension UIFont
{
    class func regularFontOfSize(size:CGFloat) -> UIFont
    {
        return UIFont.systemFont(ofSize: proportionalFontSize(size: size))
    }
    
    class func boldFontOfSize(size:CGFloat) -> UIFont
    {
        return UIFont.boldSystemFont(ofSize: proportionalFontSize(size: size))
    }
}

// MARK: UIColor EXTENTSION
extension UIColor
{
    static var themeColor : UIColor {
        get {
            return UIColor(red:(19/255.0),green:(121/255.0),blue:(52/255.0),alpha:1.0)
        }
    }
}

// MARK: UIImageView EXTENTSION
extension UIImageView {
    
    func loadImage(from url: URL, placeHolderImage pImage: UIImage?, onCompletion completion:((Bool, UIImage?) -> Swift.Void)? = nil) {
        self.contentMode = .scaleAspectFill
        self.sd_setImage(with: url, placeholderImage: pImage, options: .retryFailed, completed: { (image, err, cacheType, url) in
            if let _ = err {
                self.contentMode = .scaleAspectFill
            }
            if let completion = completion {
                completion((err == nil), image)
            }
        })
    }
}

// MARK: MKMapView EXTENTSION
extension MKMapView {
    func adjustZoomscale(forLocation cord: CLLocationCoordinate2D) {
        let centerCordinate: CLLocationCoordinate2D = cord
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(centerCordinate, 200, 200)
        self.setRegion(region, animated: false)
    }
    
    func getAllAnnotationExceptCurrentLocation() -> [MKAnnotation] {
        var arrAnnotion: [MKAnnotation] = self.annotations
        arrAnnotion = arrAnnotion.filter { $0 !== self.userLocation }
        return arrAnnotion
    }
}


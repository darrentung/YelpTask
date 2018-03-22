//
//  LocationService.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationService: NSObject {
    
    // LOCATION CHANGE HANDLER
    internal typealias locationHandler = ((CLLocationCoordinate2D?,LocationState) -> Void)?
    
    //MARK: VARIABLES
    internal var currentLocation: CLLocationCoordinate2D?
    internal var locationState: LocationState?
    fileprivate var locationManager: CLLocationManager?
    
    fileprivate var isLocationFetched: Bool = false
    fileprivate var locationCompletion: locationHandler
    fileprivate var currentTimeStamp = 0.0
    
    //MARK:- SHARED MANAGER
    static let shared : LocationService = {
        let instance = LocationService()
        return instance
    }()
    
    //MARK: INIT
    override init() {
        super.init()
        self.locationState = .notDetermined
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.distanceFilter = kCLDistanceFilterNone
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }

    
    //MARK: GET LOCATION
    func getLocation(onCompletion completionHandler: locationHandler) -> Void {
        
        if(CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied) {
            self.redirectToSettingsAlert()
            return
        }
        
        self.locationCompletion = completionHandler
        self.currentTimeStamp = Date().timeIntervalSince1970
        if let validlocationManager = self.locationManager {
            self.isLocationFetched = false
            validlocationManager.startUpdatingLocation()
        }
    }
    
    
    //MARK: REDIRECT USER TO SETTINGS
    private func redirectToSettingsAlert() {
        
        AlertUtils.displayAlertWithTitle(title: Message.AppName, andMessage: Message.locatonServiceMessage, buttons: ["Cancel","OK"]) { (buttonIndex) in
            switch buttonIndex {
            case 1:
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                break
            default:
                break
            }
        }
    }
    
    //MARK: LOCATION SERVICES DISBALED ALERT
    internal func displayEnableLocationServiceAlert() {
        
        AlertUtils.displayAlertWithTitle(title: Message.AppName, andMessage: Message.locationEnableMessage, buttons: ["Cancel","Enable"]) { (buttonIndex) in
            switch buttonIndex {
            case 1:
                self.redirectToSettingsAlert()
                break
            default:
                break
            }
        }
    }
}

//MARK: CLLocationManagerDelegate METHODS
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            self.locationState = .retricted
            if let validCompetionHandler = self.locationCompletion {
                validCompetionHandler(nil, .retricted)
            }
            self.locationCompletion = nil
            
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.isLocationFetched == false {
            self.locationState = .ready
            self.isLocationFetched = true
            let newLocation = locations.last
            self.currentLocation = newLocation!.coordinate
            
            if (self.currentTimeStamp != Date().timeIntervalSince1970) {
                self.locationManager?.stopUpdatingLocation()
                if let validCompetionHandler = self.locationCompletion {
                    validCompetionHandler(self.currentLocation!, .ready)
                }
                self.locationCompletion = nil
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error :: \(error.localizedDescription)")
        
        if (error as NSError).code == 0 {
            
            guard self.currentLocation != nil else {
                return
            }
            
            if let validCompetionHandler = self.locationCompletion {
                validCompetionHandler(self.currentLocation!, .ready)
            }
            return
        }
        
        if let validCompetionHandler = self.locationCompletion {
            validCompetionHandler(nil, .failed)
        }
        self.locationCompletion = nil
    }
}

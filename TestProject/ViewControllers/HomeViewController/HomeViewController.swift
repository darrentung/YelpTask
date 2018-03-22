//
//  HomeViewController.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import MapKit
import YelpAPI

class HomeViewController: BaseViewController {
    
    //MARK: VARIABLES
    @IBOutlet weak var mapViewBusinesses: MapView!

    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TITLE
        self.title = Titles.TitleHomeScreen
        
        // SELECT ANNOTATION HANDLER
        self.mapViewBusinesses.businessSelectedHandler = { (selectedBusiness) in
            self.performSegue(withIdentifier: Segue.ToBusinessDetailsScreen, sender: selectedBusiness)
        }

        // GET LOCATION
        LocationService.shared.getLocation { (currentLocation, locationPermissionState) in
            
            //MARK: SUBSCRIBE FOR MAP REGION CHANGES
            self.mapViewBusinesses.shouldAllowRegionChangeUpdates = true
            
            guard locationPermissionState == .ready else {
                return
            }
            
            // SET MAP REGION
            self.mapViewBusinesses.adjustZoomscale(forLocation: currentLocation!)
            
            // CLEAR ANNOTATIONS
            self.mapViewBusinesses.removeAnnotations(self.mapViewBusinesses.getAllAnnotationExceptCurrentLocation())
            
            // GET BUSINESSES FROM YELP
            let yelpCoordinate:YLPCoordinate = YLPCoordinate(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude)
            ServiceManager.shared.getSearchResult(fromCoordinate: yelpCoordinate) { (arrBusiness) in
                for businessToDisplay in arrBusiness {
                    let annotation = Annotation(withBusinessInfo: businessToDisplay)
                    self.mapViewBusinesses.addAnnotation(annotation)
                }
            }
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // BUSINESS DETAILS SCREEN
        if segue.identifier == Segue.ToBusinessDetailsScreen {
            
            guard sender is Business else {
                return
            }
            let businessDetailsVC : BusinessDetailsViewController = segue.destination as! BusinessDetailsViewController
            businessDetailsVC.businessToDisplay = sender as? Business
        }
    }
}

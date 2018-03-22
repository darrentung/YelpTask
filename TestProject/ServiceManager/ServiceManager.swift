//
//  AppDelegate.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import YelpAPI
import SVProgressHUD

class ServiceManager: NSObject {
	
    var yelpClient:YLPClient?
    let businessCategory = "restaurant"

    //MARK:- SHARED MANAGER
    static let shared : ServiceManager = {
        let instance = ServiceManager()
        
        if IS_INTERNET_AVAILABLE() {
            YLPClient.authorize(withAppId: YelpKeys.YelpAppId, secret: YelpKeys.YelpAppSecretKey, completionHandler: { (client, error) in
                print("Error : \(String(describing: error))")
                guard client != nil else {
                    return
                }
                instance.yelpClient = client!
            })
        }
        return instance
    }()
    
    override init() {
        super.init()
    }

    //MARK: GET SEARCH RESULTS
    func getSearchResult(fromCoordinate coordinate:YLPCoordinate, withSearchBlock search:@escaping SearchResultBlock) -> Void
    {

        if IS_INTERNET_AVAILABLE() {
            
            guard self.yelpClient != nil else {
                sleep(5)
                self.getSearchResult(fromCoordinate: coordinate, withSearchBlock: search)
                return
            }

            HUDUtils.showCustomLoader()

            self.yelpClient?.search(with: coordinate, term: self.businessCategory, limit: 10, offset: 1, sort: .bestMatched) { (result, error) in
                
                HUDUtils.hideCustomLoader()
                if error == nil
                {
                    //UPDATE LOCAL DATABASE AND GET ALL BUSINESSES
                    DatabaseManager.save(bussinesses: (result?.businesses)!, onCompletion: { (arrBusiness) in
                        search(arrBusiness)
                    })
                    
                }else {
                    AlertUtils.displayAlertWithMessage(message: (error?.localizedDescription)!)
                }
            }

        }else{
            // GET BUSINESSES FROM LOCAL DATABASE
            DatabaseManager.save(bussinesses: [], onCompletion: { (arrBusiness) in
                search(arrBusiness)
            })
        }
    }
    
    fileprivate func callGooglePlaceGETApi(url: String, parameters: [String : Any]?, loader: Bool, completionHandler: (( Bool, NSDictionary?, String?) -> Void)?) {
        
//        guard appdelegate.IS_INTERNET_AVAILABLE() else {
//            BRAlertVIew.displayNoInternetAlert()
//            return
//        }
        
//        if loader {
//            BRServiceManager.showLoader()
//        }
        
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        self.lastRequst = Alamofire.request(url, method: .get, parameters: parameters)
//        self.lastRequst?.responseJSON(completionHandler: { (response) in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//            if loader {
//                BRServiceManager.hideLoader()
//            }
//
//            if response.result.isFailure {
//                if let validHandler = completionHandler {
//                    if (response.result.error! as NSError).code == -999 {
//                        return
//                    }
//                    let strErrorNessage : String = (response.result.error?.localizedDescription)! as String
//                    BRErrorView.showErrorView(withMessage: strErrorNessage, andCompletion: nil)
//                    validHandler(false, nil, strErrorNessage)
//                }
//            }
//            else {
//                do {
//                    if let dictResponse = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary {
//                        print("dictResponse \(String(describing: dictResponse))")
//
//                        if let validHandler = completionHandler {
//                            validHandler(true, dictResponse, nil)
//                        }
//                    }
//                    else {
//                        if let validHandler = completionHandler {
//                            validHandler(false, nil, nil)
//                        }
//                    }
//                } catch let error as NSError {
//                    if let validHandler = completionHandler {
//                        let strErrorMessage : String = error.localizedDescription
//                        validHandler(false, nil, strErrorMessage)
//                    }
//                }
//            }
//        })
    }

    //MARK:- GET PLACEInfo
    func getPlaceInfo(withPlaceId placeId: String, callback : @escaping (_ items : PlaceInfo?, _ errorDescription : String?) -> Void) {
        
//        self.lastRequst?.cancel()
//        var params: [String: Any] = [:]
//        params[RequestKeys.googlePlaceId] = placeId
//        params[RequestKeys.googlePlacesAPIKey] = RequestKeys.googlePlacesKeyValue
//
//        self.callGooglePlaceGETApi(url: URLs.placeinfoURL, parameters: params, loader: true) { (status, dict, errMessage) in
//            guard status == true else {
//                callback(nil, errMessage)
//                return
//            }
//
//            let results = dict?.object_forKeyWithValidationForClass_NSDictionary(aKey: "result")
//
//            let objPlaceInfo = PlaceInfo(dict: results!)
//            callback(objPlaceInfo, nil)
//        }
    }
    
    
    //MARK: SEARCH LOCATION
    func search(keyword : String, callback : @escaping (_ items : [LocationInfo]?, _ errorDescription : String?) -> Void) {
        
//        self.lastRequst?.cancel()
//        var params: [String: String] = [:]
//        params[RequestKeys.googlePlacesAPIKey] = RequestKeys.googlePlacesKeyValue
//        params[RequestKeys.keyword] = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        params[RequestKeys.components] = "country:aus"
//        params["types"] = "address"
//
//        var queryString = ""
//        for (key, value) in params {
//            if queryString == "" {
//                queryString = key + "=" + value
//            }
//            else {
//                queryString = queryString + "&" + key + "=" + value
//            }
//        }
//
//        self.callGooglePlaceGETApi(url: URLs.placeautocompleteURL + queryString, parameters: nil, loader: false) { (status, dict, errMessage) in
//            guard status == true else {
//                callback(nil, errMessage)
//                return
//            }
//
//            let results = dict?.object_forKeyWithValidationForClass_NSArray(aKey: ResponseKeys.results)
//            print("results = \(results!.count)")
//
//            var locationInfo: [LocationInfo] = []
//            for result in results! {
//                if result is NSDictionary {
//                    let locationDetail : LocationInfo = LocationInfo(dict: result as! NSDictionary)
//                    locationInfo.append(locationDetail)
//                }
//            }
//            callback(locationInfo, nil)
//        }
        
    }

}


class LocationInfo: NSObject {
    
    var placeId : String = ""
    var placename : String = ""
    var vicinity : String = ""
    
    override init() {
        super.init()
    }
    
    convenience init(dict detailsdict: NSDictionary) {
        self.init()
//        let dictstructuredAddress = detailsdict.object_forKeyWithValidationForClass_NSDictionary(aKey: "structured_formatting")
//
//        self.placename = dictstructuredAddress.object_forKeyWithValidationForClass_String(aKey: "main_text")
//        self.placeId = detailsdict.object_forKeyWithValidationForClass_String(aKey: "place_id")
//        self.vicinity = dictstructuredAddress.object_forKeyWithValidationForClass_String(aKey: "secondary_text")
        
    }
    
}


class PlaceInfo: NSObject {
    
//    var placeId : String = ""
//    var location : CLLocation = CLLocation.init(latitude: 0.0, longitude: 0.0)
//    var placename : String = ""
//    var sublocality : String = ""
//    var formattedAddress : String = ""
//    var postalCode : String = ""
//    var streetnumber: String = ""
//    var route: String = ""
//    var suburbId: Int = -1
//    var subpremise: String = ""
//    var getStreetAddress: String {
//        get {
//
//            if self.formattedAddress.contains(self.streetnumber + " " + self.route) {
//
//                let arrfromattedAddres = self.formattedAddress.components(separatedBy: ". ")
//                if let objStr = (arrfromattedAddres.filter{ $0.contains(self.streetnumber + " " + self.route) }).first, let index = arrfromattedAddres.index(of: objStr)  {
//
//                    var i = 0
//                    var str = ""
//                    while i < index {
//                        str = str + " \(arrfromattedAddres[i])"
//                        i = i+1
//                    }
//                    return str
//                }
//                return ""
//            }
//            else {
//
//                if (self.subpremise.textlength > 0) && (self.streetnumber.textlength > 0) && self.route.textlength > 0 {
//                    return "\(self.subpremise)/\(self.streetnumber)  \(self.route)"
//                }
//                else if(self.streetnumber.textlength > 0) && self.route.textlength > 0 {
//                    return "\(self.streetnumber)  \(self.route)"
//                }
//                else if(self.route.textlength > 0) {
//                    return "\(self.route)"
//                }
//                else {
//                    return self.sublocality
//                }
//            }
//
//        }
//    }
    
    override init() {
        super.init()
    }
    
    convenience init(dict detailsdict: NSDictionary) {
//        self.init()
//
//        self.placename = detailsdict.object_forKeyWithValidationForClass_String(aKey: "name")
//        self.placeId = detailsdict.object_forKeyWithValidationForClass_String(aKey: "place_id")
//        self.formattedAddress = detailsdict.object_forKeyWithValidationForClass_String(aKey: "formatted_address")
//
//        let arrAddressComponent = detailsdict.object_forKeyWithValidationForClass_NSArray(aKey: "address_components")
//        for dictAddressComponent in arrAddressComponent {
//            if let dictAddressComponent = dictAddressComponent as? NSDictionary {
//                //Fetching subpremise
//                if dictAddressComponent.object_forKeyWithValidationForClass_NSArray(aKey: "types").contains("subpremise") {
//                    self.subpremise = dictAddressComponent.object_forKeyWithValidationForClass_String(aKey: "long_name")
//                }
//
//                //Fetching StreetNumber
//                if dictAddressComponent.object_forKeyWithValidationForClass_NSArray(aKey: "types").contains("street_number") {
//                    self.streetnumber = dictAddressComponent.object_forKeyWithValidationForClass_String(aKey: "long_name")
//                }
//
//                //Route
//                if dictAddressComponent.object_forKeyWithValidationForClass_NSArray(aKey: "types").contains("route") {
//                    self.route = dictAddressComponent.object_forKeyWithValidationForClass_String(aKey: "long_name")
//                }
//
//                if dictAddressComponent.object_forKeyWithValidationForClass_NSArray(aKey: "types").contains("sublocality_level_1") {
//                    self.sublocality = dictAddressComponent.object_forKeyWithValidationForClass_String(aKey: "long_name")
//                    break
//                }
//                else if dictAddressComponent.object_forKeyWithValidationForClass_NSArray(aKey: "types").contains("locality") {
//                    self.sublocality = dictAddressComponent.object_forKeyWithValidationForClass_String(aKey: "long_name")
//                    break
//                }
//            }
//        }
        
//        for dictAddressComponent in arrAddressComponent {
//            if let dictAddressComponent = dictAddressComponent as? NSDictionary {
//                if dictAddressComponent.object_forKeyWithValidationForClass_NSArray(aKey: "types").contains("postal_code") {
//                    self.postalCode = dictAddressComponent.object_forKeyWithValidationForClass_String(aKey: "long_name")
//                    break
//                }
//            }
//        }
//        
//        let dictgeometry = detailsdict.object_forKeyWithValidationForClass_NSDictionary(aKey: "geometry")
//        let dictlocation = dictgeometry.object_forKeyWithValidationForClass_NSDictionary(aKey: "location")
//        let lat = dictlocation["lat"] as! CLLocationDegrees
//        let long = dictlocation["lng"] as! CLLocationDegrees
//        self.location = CLLocation(latitude: lat, longitude: long)
//        
//        //Retrive suburb - this will called on every suburb selection
//        if self.postalCode.textlength > 0 {
//            self.retrivesuburbId()
//        }
    }
    
//    fileprivate func retrivesuburbId() {
//        BRServiceManager.shared.getSuburbs(forSearch: self.postalCode.textlength > 0 ? self.postalCode : self.sublocality) { (isSuccess, arrSuburb) in
//            guard isSuccess else {
//                return
//            }
//
//
//            if let objSuburb = (arrSuburb.filter{ $0.suburbName.lowercased() == self.sublocality.lowercased()}).first {
//                self.suburbId = objSuburb.suburbId.intValue
//            }
//            else if let objSuburb = (arrSuburb.filter{ $0.suburbName.lowercased().contains(self.sublocality.lowercased())}).first {
//                self.suburbId = objSuburb.suburbId.intValue
//            }
//            else {
//                self.suburbId = arrSuburb[0].suburbId.intValue
//            }
//        }
//    }
}


//
//  DatabaseManager.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import YelpAPI
import CoreData
import SDWebImage


class DatabaseManager : NSObject {
    
    static var moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    //MARK: SAVE BUSINESSES
    class func save(bussinesses arrayBusiness : [YLPBusiness], onCompletion completionHandler:SaveBusinessLocallyBlock) -> Void {
        
        moc.persistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        
        for business in arrayBusiness {

            // CHECKING IF THE RECEIVED BUSINESS ALREADY EXISTS OR NOT
            var businessToAddOrUpdate : Business?
            let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
            let predicateBusinessIdentifier = NSPredicate(format: "businessIdentifier == %@",business.identifier)
            fetchRequest.predicate = predicateBusinessIdentifier
//            let arrBusiness = try! appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            let arrBusiness = try! moc.fetch(fetchRequest)

            // IF A BUSINESS EXISTS, THEN UPDATE THE DETAILS WITH LATEST ONES, ELSE INSERT NEW RECORD
            if arrBusiness.count > 0 {
                businessToAddOrUpdate = arrBusiness.first
            }else{
//                businessToAddOrUpdate = NSEntityDescription.insertNewObject(forEntityName: "Business", into: appDelegate.persistentContainer.viewContext) as? Business
                businessToAddOrUpdate = NSEntityDescription.insertNewObject(forEntityName: "Business", into: moc) as? Business
            }
            
            // SETTING UP THE BUSINESS DETAILS
            businessToAddOrUpdate?.businessName = business.name
            businessToAddOrUpdate?.businessIdentifier = business.identifier
            businessToAddOrUpdate?.businessAddress = business.location.address.joined(separator: ", ")
            businessToAddOrUpdate?.businessPhone = business.phone
            businessToAddOrUpdate?.businessURL = business.url.absoluteString
            businessToAddOrUpdate?.businessImageURL = business.imageURL?.absoluteString
            businessToAddOrUpdate?.businessRating = business.rating
            businessToAddOrUpdate?.businessReviewsCount = Int64(business.reviewCount)
            businessToAddOrUpdate?.latitude = (business.location.coordinate?.latitude)!
            businessToAddOrUpdate?.longitude = (business.location.coordinate?.longitude)!
            
            // SAVING BUSINESS CATEGORIES
            var arrCategories : [Category] = []
            for category in business.categories {
                
//                let categoryToAdd = NSEntityDescription.insertNewObject(forEntityName: "Category", into: appDelegate.persistentContainer.viewContext) as? Category
                let categoryToAdd = NSEntityDescription.insertNewObject(forEntityName: "Category", into: moc) as? Category
                categoryToAdd?.catgoryName = category.name
                categoryToAdd?.categoryAlias = categoryToAdd?.categoryAlias
                arrCategories.append(categoryToAdd!)
            }

            businessToAddOrUpdate?.categories = NSSet(array: arrCategories)
            
        }
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    
        guard completionHandler != nil else {
            return
        }
        
        // RETURNING ALL BUSINESSES FROM LOCAL DATABASE
        let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
//        let arrBusinessToReturn = try! appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        let arrBusinessToReturn = try! moc.fetch(fetchRequest)
        completionHandler!(arrBusinessToReturn)
    }

}



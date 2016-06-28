//
//  Items.swift
//  sushidex
//
//  Created by Yuuya Masada on 5/1/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//

import Foundation
import CoreData


class Items: NSManagedObject {
    
    static let entityName = "Items"
    
//    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//    
//    
//    // SAVE ALL CHANGES
//    
//    func saveChanges(){
//        do{
//            try moc.save()
//        } catch let error as NSError {
//            // failure
//            print(error)
//        }
    }
    
    // CREATE NEW ITEM
    
//    class func saveSid(sid: String) {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let moc = appDelegate.managedObjectContext
//
//        let newSid = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: moc)
//        
//        newSid.setValue("\(sid)", forKey: "sid")
//        newSid.setValue(1, forKey: "counter")
//        newSid.setValue("no notes", forKey: "notes")
//        
//        do {
//            try moc.save()
//            
//        } catch {
//            print("Unable to save managed object context.")
//        }
//    }
//    
//    class func fetchRecordsForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
//        // Create Fetch Request
//        let fetchRequest = NSFetchRequest(entityName: entity)
//        
//        // Helpers
//        var result = [NSManagedObject]()
//        
//        do {
//            // Execute Fetch Request
//            let records = try managedObjectContext.executeFetchRequest(fetchRequest)
//            
//            if let records = records as? [NSManagedObject] {
//                result = records
//            }
//            
//        } catch {
//            print("Unable to fetch managed objects for entity \(entity).")
//        }
//        
//        return result
//    }
//    
//    class func createRecordForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
//        // Helpers
//        var result: NSManagedObject? = nil
//        
//        // Create Entity Description
//        let entityDescription = NSEntityDescription.entityForName(entity, inManagedObjectContext: managedObjectContext)
//        
//        if let entityDescription = entityDescription {
//            // Create Managed Object
//            result = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        }
//        
//        return result
//    }
    
    // GET ITEM BY ID
    
//    func getById(id: NSManagedObjectID) -> Items? {
//        return moc.objectWithID(id) as? Items
//    }
    
    
    // Gets & Fetch all with an specified predicate.
    // Predicates examples:
    // - NSPredicate(format: "name == %@", "Juan Carlos")
    // - NSPredicate(format: "name contains %@", "Juan")
    
    
//    func get(withPredicate queryPredicate: NSPredicate) -> [Items]{
//        let fetchRequest = NSFetchRequest(entityName: Items.entityName)
//        
//        fetchRequest.predicate = queryPredicate
//        
//        do {
//            let response = try moc.executeFetchRequest(fetchRequest)
//            return response as! [Items]
//            
//        } catch let error as NSError {
//            // failure
//            print(error)
//            return [Items]()
//        }
//    }
    
    // GETS ALL with PREDICATE 001 sid
    
//    class func getSid(sid: String) -> [Items] {
//        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//
//        let fetchRequest = NSFetchRequest(entityName: "Items")
//        
//        do {
//            let result = try moc.executeFetchRequest(fetchRequest)
//            print(result)
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//        
//    }
    
    // Updates a person
//    func update(updatedItems: Items){
//        if let item = getById(updatedItems.objectID){
//            item.sid = updatedItems.sid
//            item.counter = updatedItems.counter
//        }
//    }
    
    
    // DELETES ITEM
    
//    func delete(id: NSManagedObjectID){
//        if let itemToDelete = getById(id){
//            moc.deleteObject(itemToDelete)
//        }
//    }
    
//}
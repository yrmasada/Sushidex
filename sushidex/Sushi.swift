//
//  sushi.swift
//  sushidex
//
//  Created by Yuuya Masada on 4/19/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Sushi {
    private var _name: String!
    private var _category: String!
    private var _subcategory: String!
    private var _sushiId: Int!
    private var _description: String!
    private var _english: String!
    private var _saveId: String!
    private var _counter: Int!
    private var _japanese: String!
    
    var name: String {
        return _name
    }
    
    var category: String {
        return _category
    }
    
    var subcategory: String {
        return _subcategory
    }
    
    var sushiId: Int {
        return _sushiId
    }
    
    var description: String {
        return _description
    }
    
    var english: String {
        return _english
    }
    
    var saveId: String {
        return _saveId
    }
    
    var counter: Int {
        return _counter
    }
    
    var japanese: String {
        return _japanese
    }
    
    
    init(name: String, category: String, subcategory: String, sushiId: Int, description: String, english: String, japanese: String, saveId: String, counter: Int) {
        self._name = name
        self._category = category
        self._subcategory = subcategory
        self._sushiId = sushiId
        self._description = description
        self._english = english
        self._japanese = japanese
        self._saveId = saveId
        self._counter = counter
    }
    
    class func currentCount(sid: String) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false
        print("fetch request 2: \(fetchRequest)")
        
        let predicate = NSPredicate(format: "sid == %@", "\(sid)")
        
        fetchRequest.predicate = predicate
        
        
        do {
            
            let response = try moc.executeFetchRequest(fetchRequest)
            
            for result in response as! [NSManagedObject] {
                
                let currentCount = result.valueForKey("counter") as! Int
                
                return currentCount
                
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        return 0
    }
    
}




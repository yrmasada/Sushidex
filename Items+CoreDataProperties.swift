//
//  Items+CoreDataProperties.swift
//  sushidex
//
//  Created by Yuuya Masada on 5/1/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Items {

    @NSManaged var counter: NSNumber?
    @NSManaged var notes: String?
    @NSManaged var sid: String?

}

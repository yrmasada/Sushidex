//
//  Sushi.swift
//  sushidex
//
//  Created by Yuuya Masada on 4/30/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Sushi: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    private var _name: String!
    private var _sushiId: Int!
    
    var name: String {
        return _name
    }
    
    var sushiId: Int {
        return _sushiId
    }
    
    init(name: String, sushiId: Int) {
        self._name = name
        self._sushiId = sushiId
    }

}

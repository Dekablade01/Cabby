//
//  Location.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class Location: Object {
    dynamic var lat:Double = 0.0
    dynamic var long:Double = 0.0
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
        
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init() {
        super.init()
    }
    

}

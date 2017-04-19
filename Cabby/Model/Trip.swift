//
//  Trip.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class Trip: Object {
    dynamic var origin:Location? = Location(lat: 0.0, long: 0.0, name: "")
    dynamic var destination:Location? = Location(lat: 0.0, long: 0.0, name: "")
    

    
    init(origin: Location, destination: Location) {
        self.origin = origin
        self.destination = destination
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

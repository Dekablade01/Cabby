//
//  Card.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift
import Realm


class Card: Object {
    
    dynamic var cardNumber:String = ""
    dynamic var cardStatus:Bool = false
    
    init(cardNumber: String, cardStatus: Bool) {
        self.cardStatus = cardStatus
        self.cardNumber = cardNumber
        
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

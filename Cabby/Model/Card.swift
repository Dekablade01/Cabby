//
//  Card.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift


class Card: Object {
    
    dynamic var cardNumber:String = ""
    dynamic var expireDate:String = ""
    dynamic var cvv:String = ""
    dynamic var status:Bool = false
    dynamic var displayCardNumber: String = ""
    
}

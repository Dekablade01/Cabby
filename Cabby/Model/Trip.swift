//
//  Trip.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift

class Trip: Object {
    
    dynamic var origin:Location? = nil
    dynamic var destination:Location? = nil
    dynamic var date:String = ""
    dynamic var time:String = ""

}

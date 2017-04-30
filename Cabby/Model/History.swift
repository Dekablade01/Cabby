//
//  History.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/29/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class History: NSObject {
    
    var origin: String = ""
    var destination: String = ""
    var time: String = ""
    var favoured: Bool = false
    
    init(origin: String, destination: String, time: String, favoured: Bool) {
        self.origin = origin
        self.destination = destination
        self.time = time
        self.favoured = favoured
        
    }
    override init() {
        super.init()
    }

}

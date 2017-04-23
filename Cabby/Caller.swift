//
//  Caller.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class Caller: NSObject {
    
    var phoneNumber:String = ""
    var name:String = ""
    var status: String = ""
    
    init(phone: String, name: String, status: String) {
        self.phoneNumber = phone
        self.name = name
        self.status = status
        
        
        super.init()
    }

}

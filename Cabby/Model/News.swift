//
//  News.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class News: NSObject {
    
    var heading1: String = ""
    var heading2: String = ""
    
    var dateAndTime: String = ""
    
    init(heading1: String, heading2: String ,dateAndTime: String) {
        self.heading1 = heading1
        self.heading2 = heading2
        self.dateAndTime = dateAndTime
        
        super.init()
    }

}

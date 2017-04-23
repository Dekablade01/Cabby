//
//  NewsCollectionViewCell.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var heading1Label: UILabel!
    
    @IBOutlet weak var heading2Label: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    var heading1:String {
        set { heading1Label.text = newValue }
        get { return heading1Label.text ?? ""}
    }
    var heading2:String {
        set { heading2Label.text = newValue }
        get { return heading1Label.text ?? "" }
    }
    var dateAndTime:String {
        set { dateAndTimeLabel.text = newValue }
        get { return dateAndTimeLabel.text ?? "" }
    }
    
}

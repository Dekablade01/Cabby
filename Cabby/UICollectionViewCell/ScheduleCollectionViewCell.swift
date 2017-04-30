//
//  ScheduleCollectionViewCell.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    var handler:(()->())?
    var moreDetailHandler:(()->())?
    
    
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    var dateAndTime:String {
        get { return dateAndTimeLabel.text ?? "" }
        set { dateAndTimeLabel.text = newValue }
    }
    
    @IBOutlet weak var originLabel: UILabel!
    var origin: String {
        get { return originLabel.text ?? "" }
        set { originLabel.text = newValue }
    }
    @IBOutlet weak var destinationLabel: UILabel!
    var destination: String {
        get { return destinationLabel.text ?? "" }
        set { destinationLabel.text = newValue }
    }
    @IBAction func pressedCancel(_ sender: UIButton) {
        handler?()
    }
    @IBAction func pressedMoreDetail(_ sender: UIButton) {
        moreDetailHandler?()
        
    }

}

//
//  HistoryCollectionViewCell.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/29/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favouriteIcon: UIButton!
    
    var origin: String {
        get { return originLabel.text ?? "" }
        set { originLabel.text = newValue }
    }
    var destination: String {
        get { return destinationLabel.text ?? "" }
        set { destinationLabel.text = newValue }
    }
    var time: String {
        get { return timeLabel.text ?? "" }
        set { timeLabel.text = newValue }
    }
    
    
    @IBAction func addToFavourite(_ sender: UIButton) {
        
        if  ( favouriteIcon.currentBackgroundImage == #imageLiteral(resourceName: "favourite-icon"))
        {
            favouriteIcon.setBackgroundImage(#imageLiteral(resourceName: "blank-favourite"), for: .normal)
        }
        else
        {
            favouriteIcon.setBackgroundImage(#imageLiteral(resourceName: "favourite-icon"), for: .normal)
        }
        
    }
}

//
//  FavouriteCollectionViewCell.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/30/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell
{
    var bookHandler: (()->())?
    var removeHandler: (()->())?
    
    @IBOutlet weak var destinationTextLabel: UILabel!
    var destinationName: String {
        get { return destinationTextLabel.text ?? "" }
        set { destinationTextLabel.text = newValue }
    }
    @IBOutlet weak var originTextLabel: UILabel!
    var originName: String {
        get { return originTextLabel.text ?? "" }
        set { originTextLabel.text = newValue } 
    }
    @IBAction func pressedBook(_ sender: UIButton) {
        bookHandler?()
    }
    
    @IBAction func pressedRemove(_ sender: UIButton) {
        removeHandler?()
    }
}

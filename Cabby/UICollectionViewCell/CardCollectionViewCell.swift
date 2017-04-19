//
//  CardCollectionViewCell.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardStatusImageView: UIImageView!
    
    public var status: Bool = false {
        didSet {
        
            if (status == false)
            {
                cardStatusImageView.image = #imageLiteral(resourceName: "uncheck")
            }
            else
            {
                cardStatusImageView.image = #imageLiteral(resourceName: "check")
            }
        }
    }
    
    public var cardNumber: String {
        get { return cardNumberLabel.text ?? "" }
        set { cardNumberLabel.text = newValue }
    }
    
    
}

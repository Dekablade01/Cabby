//
//  SetupTextField+UIViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/18/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupTextField (textField: UITextField, placeHolderString: String, placeHolderColor: UIColor)
    {
        
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderString   ,
                                                             attributes:[NSForegroundColorAttributeName: placeHolderColor])
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1.0
    }
}

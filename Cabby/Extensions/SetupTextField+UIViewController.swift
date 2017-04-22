//
//  SetupTextField+UIViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/18/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupTextField (textField: UITextField, placeHolderString: String, placeHolderColor: UIColor, borderColor: UIColor, borderWidth: CGFloat)
    {
        let cgColor = borderColor.cgColor
        
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderString   ,
                                                             attributes:[NSForegroundColorAttributeName: placeHolderColor])
        textField.layer.borderColor = cgColor
        textField.layer.borderWidth = borderWidth
    }
}

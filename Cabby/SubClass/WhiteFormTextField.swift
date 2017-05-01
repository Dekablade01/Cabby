//
//  WhiteFormTextField.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import FormTextField

class WhiteFormTextField: FormTextField {
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit()
    {
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
        textColor = UIColor.white
        disabledBorderColor = .white
        validBorderColor = .white
        activeBorderColor = .white
        enabledBorderColor = .white
        invalidBorderColor = .white
        inactiveBorderColor = .white
        
        disabledTextColor = .white
        validTextColor = .white
        activeTextColor = .white
        enabledTextColor = .white
        invalidTextColor = .white
        defaultTextColor = .white
        inactiveTextColor = .white
        

        
    }
    
    
    var padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

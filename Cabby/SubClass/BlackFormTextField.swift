//
//  BlackFormTextField.swift
//  Cabby
//
//  Created by Issarapong Poesua on 5/4/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import FormTextField


class BlackFormTextField: FormTextField {
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
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        
        textColor = UIColor.black
        disabledBorderColor = .black
        validBorderColor = .black
        activeBorderColor = .black
        enabledBorderColor = .black
        invalidBorderColor = .black
        inactiveBorderColor = .black
        
        disabledTextColor = .black
        validTextColor = .black
        activeTextColor = .black
        enabledTextColor = .black
        invalidTextColor = .black
        defaultTextColor = .black
        inactiveTextColor = .black
        
        
        
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

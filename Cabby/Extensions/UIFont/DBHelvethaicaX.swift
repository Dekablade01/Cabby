//
//  UIFont+HelveticaNeue.swift
//  ShopSpot
//
//  Created by Wipoo Shinsirikul on 19/2/16.
//  Copyright © 2016 Fill8. All rights reserved.
//

import UIKit

extension UIFont
{
    fileprivate static let familyName = "DB Helvethaica X"
    
    fileprivate enum Style: String
    {
        case Regular = "Regular"
        case Light = "Light"
        
        func fontName(_ familyName: String) -> String
        {
            return "\(familyName)-\(self.rawValue)"
        }
    }
    
    // MARK: - Regular
    
    fileprivate class func DBHelveticaX_Regular(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: Style.Regular.fontName(UIFont.familyName), size: size)!
    }
    
    @objc class func DBHelveticaX_Regular(size: CGFloat) -> UIFont
    {
        return .DBHelveticaX_Regular(size)
    }

    
    // MARK: - Light
    
    fileprivate class func DBHelveticaX_Light(_ fontSize: CGFloat) -> UIFont
    {
        return UIFont(name: Style.Light.fontName(UIFont.familyName), size: fontSize)!
    }
    
    @objc class func DBHelveticaX_Light(size: CGFloat) -> UIFont
    {
        return .DBHelveticaX_Light(size)
    }

}

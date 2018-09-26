//
//  UIColor+CustomColors.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 9/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import  UIKit

extension UIColor
{
    class func blueGradientColor() -> UIColor
    {
        return UIColor(red: 65.0 / 255.0, green: 196.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
    }
    class func orangeGradient() -> UIColor
    {
        return UIColor(red: 246.0 / 255.0, green: 117.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    }
    class func orangeGradient30opacity() -> UIColor
    {
        return UIColor(red: 246.0 / 255.0, green: 117.0 / 255.0, blue: 68.0 / 255.0, alpha: 0.3)
    }
    
    class func colorWithCustomHexString(hex:String)->UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#"))
        {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6)
        {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

//
//  UIViewExtension.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 5/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // cornerRadius of view
    @IBInspectable var cornerRadius : CGFloat
    {
        set
        {
            layer.cornerRadius = newValue
        }
        get
        {
            return layer.cornerRadius
        }
    }
    // borderWidth of view
    @IBInspectable var borderWidth : CGFloat
    {
        set
        {
            layer.borderWidth = newValue
        }
        get
        {
            return layer.borderWidth
        }
    }
    
    // borderColor of view
    @IBInspectable var borderColor: UIColor?
    {
        get
        {
            if let color = layer.borderColor
            {
                return UIColor.init(cgColor: color)
            }
            return nil
        }
        set(newValue)
        {
            layer.borderColor = newValue?.cgColor
        }
    }
}

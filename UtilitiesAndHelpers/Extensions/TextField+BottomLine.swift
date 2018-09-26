//
//  TextFieldExtension.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 5/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import  UIKit


extension UITextField
{
    public func hideAssistantBar() // hide do undo copy for textfield
    {
        if #available(iOS 9.0, *) {
            let assistant = self.inputAssistantItem;
            assistant.leadingBarButtonGroups = [];
            assistant.trailingBarButtonGroups = [];
        }
    }
    
    // set bottom border line for textfield
    public func setBottomLine(borderColor: UIColor)
    {
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}

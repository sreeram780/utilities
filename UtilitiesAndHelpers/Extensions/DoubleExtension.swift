//
//  DoubleExtension.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 5/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
extension Double {
    // Rounds the double to decimal places value
    var roundToTwoDecimal:String
    {
        return String(format: "%.2f", self)
    }
}

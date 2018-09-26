//
//  UIButton+RoundCorner.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 9/10/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import UIKit
extension UIButton
{
    func roundCorners(corners:UIRectCorner, radius: CGFloat)
    {
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.layer.bounds
        borderLayer.strokeColor = UIColor.green.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 10.5
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        borderLayer.path = path.cgPath
        self.layer.addSublayer(borderLayer)
    }
}

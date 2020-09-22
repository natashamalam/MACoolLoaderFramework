//
//  UIColorExtension.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/09/21.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit


public extension UIColor{
    
    static func lighterShade(ofColor color: UIColor, andPercentage percentage: CGFloat)->UIColor{
        let lighterColor = colorShade(forColor: color, by: percentage)
        if let color = lighterColor{
            return color
        }
        return UIColor.white
    }
    
    static func darkerShade(ofColor color: UIColor, andPercentage percentage: CGFloat)->UIColor{
        let darkerColor = colorShade(forColor: color, by: -1 * percentage)
        if let color = darkerColor{
            return color
        }
        return UIColor.black
    }
    static func colorShade(forColor color: UIColor, by percentage: CGFloat?) -> UIColor? {
        let defaultMultiplier : CGFloat = 0.30
        
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        if let multiplier = percentage{
            if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                return UIColor(red: min(red + multiplier/100, 1.0),
                               green: min(green + multiplier/100, 1.0),
                               blue: min(blue + multiplier/100, 1.0),
                               alpha: 1)
            }
        }
        else {
            if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                return UIColor(red: min(red + defaultMultiplier, 1.0),
                               green: min(green + defaultMultiplier, 1.0),
                               blue: min(blue + defaultMultiplier, 1.0),
                               alpha: 1)
            }
        }
        return nil
    }
}

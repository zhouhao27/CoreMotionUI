//
//  UIColor+Hex.swift
//  One-Fourth
//
//  Created by ZhouHao on 22/7/14.
//  Copyright (c) 2014 Zeus Software. All rights reserved.
//

import UIKit

extension UIColor {
  
    // TODO: to be implemented
/*
    class func colorWithRGBHexString(rgbHexString : String) -> UIColor {
        
        //-----------------------------------------
        // Convert hex string to an integer
        //-----------------------------------------
        var hexint = 0
        
        // Create scanner
        let scanner = NSScanner(string: rgbHexString)
        
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        scanner.scanHexInt(hexint)
        
        //-----------------------------------------
        // Create color object, specifying alpha
        //-----------------------------------------
        return UIColor(red:((CGFloat) ((hexint & 0xFF0000) >> 16))/255,
                green:((CGFloat) ((hexint & 0xFF00) >> 8))/255,
                blue:((CGFloat) (hexint & 0xFF))/255,
                alpha:1.0)
    }
*/
    
    class func colorWithRGBHex(hex : UInt32) -> UIColor {
        
        let r : UInt32 = (hex >> 16) & 0xFF
        let g : UInt32 = (hex >> 8) & 0xFF
        let b : UInt32 = (hex) & 0xFF
        
        return UIColor(red: CGFloat(Float(r) / 255.0), green: CGFloat(Float(g) / 255.0), blue: CGFloat(Float(b) / 255.0), alpha: 1.0)
    }
    
    class func colorWithRGBHex(hex : UInt32, alpha : CGFloat) -> UIColor {

        let r : UInt32 = (hex >> 16) & 0xFF
        let g : UInt32 = (hex >> 8) & 0xFF
        let b : UInt32 = (hex) & 0xFF
        
        return UIColor(red: CGFloat(Float(r) / 255.0), green: CGFloat(Float(g) / 255.0), blue: CGFloat(Float(b) / 255.0), alpha: alpha)
    }
    
}
//
//  UIImage+Color.swift
//  SynoAnto
//
//  Created by ZhouHao on 18/7/14.
//  Copyright (c) 2014 Zeus Software. All rights reserved.
//

import UIKit

extension UIImage {
    
    // class init(color : UIColor) doesn't work
        
    class func imageWithColor(color : UIColor) -> UIImage {
        
        let rect : CGRect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContextRef = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect);
        
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

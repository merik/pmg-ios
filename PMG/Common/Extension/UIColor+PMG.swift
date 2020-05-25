//
//  UIColor+PMG.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexRGBValue hexValue: CUnsignedLongLong, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16)/255.0, green: CGFloat((hexValue & 0xFF00) >> 8)/255.0, blue: CGFloat(hexValue & 0xFF)/255.0, alpha: alpha)
    }
    
    convenience init(hexRGBAValue hexValue: CUnsignedLongLong, alpha: CGFloat? = nil) {
        self.init(red: CGFloat((hexValue & 0xFF000000) >> 24)/255.0, green: CGFloat((hexValue & 0xFF0000) >> 16)/255.0, blue: CGFloat((hexValue & 0xFF00) >> 8)/255.0, alpha: (alpha != nil ? alpha! : CGFloat(hexValue & 0xFF)/255.0))
    }
    
    
    convenience init(pmg colorName: PMG.Colors, alpha: CGFloat? = nil) {
        self.init(hexRGBAValue: colorName.rawValue, alpha: alpha)
    }
    
    public convenience init(pmgDark darkName: DarkProperty) {
        self.init(white: 0.0, alpha: CGFloat(darkName.rawValue)/255.0)
    }
    
  
}

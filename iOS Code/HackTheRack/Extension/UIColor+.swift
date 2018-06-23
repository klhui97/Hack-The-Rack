//
//  File.swift
//  SmartPlant
//
//  Created by KL on 29/5/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

extension UIColor{
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func appGreenColor() -> UIColor{
        return UIColor.UIColorFromRGB(rgbValue: 0x3CB371)
    }
    
    static func appBlueColor() -> UIColor{
        return UIColor.UIColorFromRGB(rgbValue: 0x00BFFF)
    }
    
    static func tempetureProgressColor() -> UIColor{
        return UIColor.UIColorFromRGB(rgbValue: 0xEB4747)
    }
}

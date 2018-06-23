//
//  UIImageView+.swift
//  SmartPlant
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

extension UIImageView{
    
    static func convertToCircleImage(image: UIImageView){
        image.layer.cornerRadius = image.frame.size.width/2
        image.borderColor = UIColor.white
        image.layer.borderWidth = 3
        image.clipsToBounds = true
    }
    
    static func convertToNormalImage(image: UIImageView){
        image.layer.cornerRadius = 0
        image.borderColor = nil
        image.layer.borderWidth = 0
        image.clipsToBounds = false
    }
    
}

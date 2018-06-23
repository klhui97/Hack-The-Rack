//
//  CustomCallOutView.swift
//  HackTheRack
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class CustomCallOutView: UIView{
    
    @IBOutlet weak var backgroudView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroudView.applyArrowDialogAppearanceWithOrientation(arrowOrientation: .down)
    }

}

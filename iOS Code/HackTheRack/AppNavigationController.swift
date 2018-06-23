//
//  AppNavigationController.swift
//  HackTheRack
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import Material

class AppNavigationController: NavigationController {
    open override func prepare() {
        super.prepare()
        guard let v = navigationBar as? NavigationBar else {
            return
        }
        
        v.dividerColor = Color.grey.lighten2
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}

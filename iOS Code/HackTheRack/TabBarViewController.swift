//
//  TabBarViewController.swift
//  HackTheRack
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Move icon to center EdgeInsets
        let inset = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        // Init tab
        let tabOne = AppNavigationController(rootViewController: CameraViewController())
        tabOne.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Tag"), tag: 0)
        tabOne.tabBarItem.imageInsets = inset
        
        let tabTwo = AppNavigationController(rootViewController: Screen1ViewController())
        tabTwo.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "search"), tag: 1)
        tabTwo.tabBarItem.imageInsets = inset

        let tabThree = AppNavigationController(rootViewController: Screen3ViewController())
        tabThree.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "trend"), tag: 1)
        tabThree.tabBarItem.imageInsets = inset
        
        // Add all view into the tab bar
        viewControllers = [tabOne, tabTwo, tabThree]
        
        // Set init view
        selectedIndex = 0
        
        // Set selected color
        tabBar.tintColor = UIColor.UIColorFromRGB(rgbValue: 0x0960dd)
    }
    
    override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
        print("didEndCustomizing")
    }

}



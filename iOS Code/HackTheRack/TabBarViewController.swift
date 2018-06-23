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
        let tabOne = AppNavigationController(rootViewController: MapViewController())
        tabOne.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "location"), tag: 0)
        tabOne.tabBarItem.imageInsets = inset
        
        let tabTwo = AppNavigationController(rootViewController: ListViewController())
        tabTwo.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Plant"), tag: 1)
        tabTwo.tabBarItem.imageInsets = inset

        // Add all view into the tab bar
        viewControllers = [tabOne, tabTwo]
        
        // Set init view
        selectedIndex = 1
        
        // Set selected color
        tabBar.tintColor = UIColor.appGreenColor()
    }
    
    override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
        print("didEndCustomizing")
    }

}



//
//  TabBarController.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 24.08.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tab in tabBarControllers {
            self.addChild(tab)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = AppColors.white
        tabBar.tintColor = AppColors.blue
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = 45.0
        tabBar.itemSpacing = 32.0
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)], for: .normal)
    }
}


//
//  tabbarViewController.swift
//  RandomAnswer
//
//  Created by Duc'sMacBook on 8/20/20.
//  Copyright © 2020 VSHR. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ranNumsNav = UINavigationController(rootViewController: RanNumVC)
        let ranwordsNav = UINavigationController(rootViewController: RanWordVC)
        
        RanWordVC.tabBarItem.title = "Words"
        RanNumVC.tabBarItem.title = "Numbers"
        
        tabBarController?.tabBar.backgroundColor = .white
        
        
        
        self.delegate = self
    }
    
}

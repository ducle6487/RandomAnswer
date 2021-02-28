//
//  AppDelegate.swift
//  RandomAnswer
//
//  Created by Duc'sMacBook on 8/20/20.
//  Copyright © 2020 VSHR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let RanNumVC = RanNumsViewController()
        let RanWordVC = RanWordsViewController()
        
        let ranNumsNav = UINavigationController(rootViewController: RanNumVC)
        let ranwordsNav = UINavigationController(rootViewController: RanWordVC)
        
        ranwordsNav.tabBarItem.title = "Words"
        ranwordsNav.tabBarItem.image = UIImage(named: "words")
        ranNumsNav.tabBarItem.title = "Numbers"
        ranNumsNav.tabBarItem.image = UIImage(named: "numbers")
        
        let tabbarVC = UITabBarController()
        tabbarVC.tabBar.selectedImageTintColor = UIColor.black
        
        tabbarVC.tabBar.backgroundColor = .white
        tabbarVC.viewControllers = [ranwordsNav,ranNumsNav]
        
        window?.rootViewController = tabbarVC
        window?.makeKeyAndVisible()
        return true
    }


}


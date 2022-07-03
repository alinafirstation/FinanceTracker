//
//  AppDelegate.swift
//  FinanceTracker
//
//  Created by Alina Cherepanova on 03.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewContoller = MainTabBarController()
        viewContoller.selectedIndex = 2
        window.rootViewController = viewContoller
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}


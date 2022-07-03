//
//  MainTabBarController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 30.01.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStartSettings()
        setupTabBar()
    }
    
    private func setupStartSettings() {
        view.backgroundColor = .white
    }

    private func setupTabBar() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .background
            //appearance.backgroundEffect = UIBlurEffect(style: .dark)

            tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                               .font: UIFont.systemFont(ofSize: 12)]
            tabBarItemAppearance.normal.iconColor = .white
            //appearance.stackedLayoutAppearance = tabBarItemAppearance
            
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        fillTabBar()
        tabBar.tintColor = .accentColorHeavy
    }
    
    private func fillTabBar() {
        let finLiteracyController = EducationViewController()
        let stocksController = StocksPortfolioViewController()
        let cryptoController = CryptoPortfolioViewController()
        let moneyController = MoneyPortfolioViewController()
        let statisticsController = StatisticsViewController()
        let finLiteracyNavController = UINavigationController(rootViewController: finLiteracyController)
        let stocksNavController = UINavigationController(rootViewController: stocksController)
        let cryptoNavController = UINavigationController(rootViewController: cryptoController)
        let moneyNavController = UINavigationController(rootViewController: moneyController)
        let statisticsNavController = UINavigationController(rootViewController: statisticsController)
        
        finLiteracyController.tabBarItem = UITabBarItem(title: TabBarItem.finLiteracy.title, image: TabBarItem.finLiteracy.image, selectedImage: nil)
        finLiteracyController.navigationItem.title = TabBarItem.finLiteracy.navTitle
        
        stocksController.tabBarItem = UITabBarItem(title: TabBarItem.stocks.title, image: TabBarItem.stocks.image, selectedImage: nil)
        stocksController.navigationItem.title = TabBarItem.stocks.navTitle
        
        cryptoController.tabBarItem = UITabBarItem(title: TabBarItem.crypto.title, image: TabBarItem.crypto.image, selectedImage: nil)
        cryptoController.navigationItem.title = TabBarItem.crypto.navTitle
        
        moneyController.tabBarItem = UITabBarItem(title: TabBarItem.money.title, image: TabBarItem.money.image, selectedImage: nil)
        moneyController.navigationItem.title = TabBarItem.money.navTitle
        
        statisticsController.tabBarItem = UITabBarItem(title: TabBarItem.statistics.title, image: TabBarItem.statistics.image, selectedImage: nil)
        statisticsController.navigationItem.title = TabBarItem.statistics.navTitle
        
        viewControllers = [finLiteracyNavController, stocksNavController, cryptoNavController, moneyNavController, statisticsNavController]
    }
}

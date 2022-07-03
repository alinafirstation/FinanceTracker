//
//  TabBarItem.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 13.03.2022.
//

import UIKit

enum TabBarItem {
    case finLiteracy
    case stocks
    case crypto
    case money
    case statistics
    
    var title: String {
        switch self {
        case .stocks:
            return "Акции"
        case .crypto:
            return "Криптовалюта"
        case .finLiteracy:
            return "Образование"
        case .money:
            return "Деньги"
        case .statistics:
            return "Статистика"
        }
    }

    var navTitle: String {
        switch self {
        case .stocks:
            return "Портфель акций"
        case .crypto:
            return "Портфель криптовалют"
        case .finLiteracy:
            return "Финансовая грамотность"
        case .money:
            return "Денежные средства"
        case .statistics:
            return "Статистика"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .stocks:
            return UIImage(named: ImageName.stockTabBar.rawValue)
        case .crypto:
            return UIImage(named: ImageName.cryptoTabBar.rawValue)
        case .finLiteracy:
            return UIImage(named: ImageName.finLiteracyTabBar.rawValue)
        case .money:
            return UIImage(named: ImageName.moneyTabBar.rawValue)
        case .statistics:
            return UIImage(named: ImageName.statisticsTabBar.rawValue)
        }
    }
    
    enum ImageName: String {
        case stockTabBar = "TabBar/stocksTabBarItem"
        case cryptoTabBar = "TabBar/cryptoTabBarItem"
        case finLiteracyTabBar = "TabBar/finLiteracyTabBarItem"
        case moneyTabBar = "TabBar/moneyTabBarItem"
        case statisticsTabBar = "TabBar/statisticsTabBarItem"
    }
}

//
//  UINavigationController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 30.01.2022.
//

import UIKit

extension UINavigationController {
    func setupNavigationController() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .background
            appearance.backgroundEffect = UIBlurEffect(style: .dark)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                              .font: AppFont.font(type: .Bold, size: 18)]
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: AppFont.font(type: .Bold, size: 18)]
    }
}

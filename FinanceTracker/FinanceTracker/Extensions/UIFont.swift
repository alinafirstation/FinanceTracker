//
//  UIFont.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 10.03.2022.
//

import UIKit

struct AppFont {
    enum FontType: String {
        case Light = "Exo2-Light"
        case Regular = "Exo2-Regular"
        case Medium = "Exo2-Medium"
        case Bold = "Exo2-Bold"
        case SemiBold = "Exo2-SemiBold"
    }
    
    static func font(type: FontType, size: CGFloat) -> UIFont{
        return UIFont(name: type.rawValue, size: size)!
    }
}


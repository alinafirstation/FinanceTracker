//
//  Double.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 27.03.2022.
//

import Foundation

extension Double {
    var trailingZero: String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        return String(formatter.string(from: number) ?? "")
    }
}

extension Double {
    func usdToRub() -> Double {
        let rubleConstant: Double = 75
        return self * rubleConstant
    }
}


//
//  String.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 29.04.2022.
//

import Foundation

extension String {
    static func currencyFormatter(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "ru_RU")

        return "\(formatter.string(from: NSNumber(value: amount as Double)) ?? "") ₽"
    }
}

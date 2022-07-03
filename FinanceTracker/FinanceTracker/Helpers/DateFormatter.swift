//
//  DateFormatter.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 20.03.2022.
//

import Foundation

extension Date {

    func toString(format: String = "dd.MM.yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

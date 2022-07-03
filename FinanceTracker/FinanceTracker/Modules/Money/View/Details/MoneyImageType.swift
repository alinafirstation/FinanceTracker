//
//  MoneyImageType.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.04.2022.
//

import Foundation

enum MoneyImageType {
    enum Income: String, CaseIterable {
        case salary
        case profits
        case moneyBag
        
        static func getType(for index: Int) -> Income {
            return allCases[index]
        }
    }
    
    enum Expense: String, CaseIterable {
        case expense
        case product
        case clothes
        case transportation
        case laugh
        
        static func getType(for index: Int) -> Expense {
            return allCases[index]
        }
    }
}



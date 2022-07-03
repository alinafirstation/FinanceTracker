//
//  StocksData.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 06.02.2022.
//

import Foundation

struct StocksData: Codable {
    let topStocks: [TopStock]
}

struct TopStock: Codable {
    let ticker: String
    let companyName: String
    let currency: String
    
    var correctCurrency: String {
        if currency == "USD" {
            return "$"
        }
        
        return ""
    }
}

struct StockPrice: Codable {
    let price: String
    
    var correctPrice: Double? {
        guard let correctPrice = Double(price)?.usdToRub() else { return nil }
        let roundedValue = round(correctPrice * 100) / 100.0
        return roundedValue
    }
}


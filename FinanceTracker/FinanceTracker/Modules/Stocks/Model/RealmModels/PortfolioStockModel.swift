//
//  PortfolioStockModel.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 20.03.2022.
//

import Foundation
import RealmSwift

@objcMembers
class PortfolioStockModel: Object {
    dynamic var ticker: String = ""
    dynamic var companyName: String = ""
    dynamic var moneyAmount: Double = 0.0
    dynamic var lots: Int = 0
    var currentPrice = RealmProperty<Double?>()
    var historyPurchaseStocks = List<PurchaseStock>()
    
    override class func primaryKey() -> String? {
        return "ticker"
    }
    
    convenience init(ticker: String,
                     companyName: String,
                     moneyAmount: Double,
                     currentPrice: Double? = nil,
                     lots: Int) {
        self.init()
        
        self.ticker = ticker
        self.companyName = companyName
        self.moneyAmount = moneyAmount
        self.lots = lots
    }
    
    var amountPrice: Double? {
        guard let currentPrice = currentPrice.value else { return nil }

        let amountPrice = currentPrice * Double(lots)
        return round(amountPrice * 100) / 100.0
    }
    
    var avgPrice: Double {
        var amountPrice = 0.0
        var amountLots = 0
        historyPurchaseStocks.forEach { purchaseStock in
            if purchaseStock.historyType == .add {
                amountPrice += purchaseStock.purchasePrice * Double(purchaseStock.lots)
                amountLots += purchaseStock.lots
            }
        }
        
        return amountPrice / Double(amountLots)
    }
    
    var profitPercentage: Double? {
        guard let currentPrice = currentPrice.value else { return nil }
        let profit = (currentPrice/avgPrice - 1) * 100
        return round(profit * 100) / 100
    }
    
    var profitMoney: Double? {
        guard let currentPrice = currentPrice.value else { return nil }
        let profit = (currentPrice - avgPrice) * Double(lots)
        return round(profit * 100) / 100
    }
}

@objcMembers
class PurchaseStock: Object {
    dynamic var privateHistoryType = HistoryType.add.rawValue
    dynamic var purchasePrice: Double = 0.0
    dynamic var lots: Int = 0
    dynamic var date: String = ""
    
    var historyType: HistoryType {
        get { return HistoryType(rawValue: privateHistoryType)! }
        set { privateHistoryType = newValue.rawValue }
    }

    convenience init(historyType: HistoryType, purchasePrice: Double, lots: Int, date: String) {
        self.init()

        self.historyType = historyType
        self.purchasePrice = purchasePrice
        self.lots = lots
        self.date = date
    }
}

enum HistoryType: String {
    case add
    case remove
}

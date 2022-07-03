//
//  PortfolioCryptoModel.swift
//  Track Finance
//
//  Created by Alina on 12.04.2022.
//

import Foundation
import RealmSwift

@objcMembers
class PortfolioCryptoModel: Object {
    dynamic var tether: String = ""
    dynamic var name: String = ""
    dynamic var moneyAmount: Double = 0.0
    dynamic var amount: Double = 0.0
    var currentPrice = RealmProperty<Double?>()
    var historyPurchaseCrypto = List<PurchaseCrypto>()
    
    override class func primaryKey() -> String? {
        return "tether"
    }
    
    convenience init(name: String,
                     tether: String,
                     moneyAmount: Double,
                     currentPrice: Double? = nil,
                     amount: Double) {
        self.init()
        
        self.name = name
        self.tether = tether
        self.moneyAmount = moneyAmount
        self.currentPrice.value = currentPrice
        self.amount = amount
    }
    
    var amountPrice: Double? {
        guard let currentPrice = currentPrice.value else { return nil }

        let amountPrice = currentPrice * Double(amount)
        return round(amountPrice * 100) / 100.0
    }
    
    var avgPrice: Double {
        var amountPrice = 0.0
        var amountLots = 0.0
        historyPurchaseCrypto.forEach { purchaseCrypto in
            if purchaseCrypto.historyType == .add {
                amountPrice += purchaseCrypto.purchasePrice * Double(purchaseCrypto.amount)
                amountLots += purchaseCrypto.amount
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
        let profit = (currentPrice - avgPrice) * Double(amount)
        return round(profit * 100) / 100
    }
}

@objcMembers
class PurchaseCrypto: Object {
    dynamic var privateHistoryType = HistoryType.add.rawValue
    dynamic var purchasePrice: Double = 0.0
    dynamic var amount: Double = 0.0
    dynamic var date: String = ""
    
    var historyType: HistoryType {
        get { return HistoryType(rawValue: privateHistoryType)! }
        set { privateHistoryType = newValue.rawValue }
    }

    convenience init(historyType: HistoryType, purchasePrice: Double, amount: Double, date: String) {
        self.init()

        self.historyType = historyType
        self.purchasePrice = purchasePrice
        self.amount = amount
        self.date = date
    }
}

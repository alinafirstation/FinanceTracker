//
//  PortfolioMoneyModel.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.04.2022.
//

import Foundation
import RealmSwift

@objcMembers
class PortfolioMoneyModel: Object {
    dynamic var id = UUID().uuidString
    dynamic var privateType = MoneyClassification.income.rawValue
    dynamic var imageName: String = ""
    dynamic var category: String = ""
    dynamic var sum: Double = 0.0
    dynamic var date: String = ""
    
    var type: MoneyClassification {
        get { return MoneyClassification(rawValue: privateType)! }
        set { privateType = newValue.rawValue }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(type: MoneyClassification, imageName: String, category: String, sum: Double, date: String) {
        self.init()

        self.type = type
        self.imageName = imageName
        self.category = category
        self.sum = sum
        self.date = date
    }
}

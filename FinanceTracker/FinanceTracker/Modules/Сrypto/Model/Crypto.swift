//
//  Crypto.swift
//  Track Finance
//
//  Created by Alina on 06.04.2022.
//

import Foundation

struct CryptoData: Codable{
    let topCrypto: [TopCryptoData]
}

struct TopCryptoData: Codable {
    let tether: String
    let name: String
}

struct CryptoPriceData: Codable {
    let symbol: String
    let price: String
    
    var correctPrice: Double? {
        guard let price = Double(price)?.usdToRub() else { return nil }
        let roundedValue = round(price * 100) / 100.0
        return roundedValue
    }
}

struct Crypto {
    let tether: String
    let name: String
    let price: Double?
}

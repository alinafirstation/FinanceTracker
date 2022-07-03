//
//  CryptoFetcherService.swift
//  Track Finance
//
//  Created by Alina on 06.04.2022.
//

import Foundation

class CryptoFetcherService {
    let networkDataFetcher = NetworkDataFetcher()
    let localDataFetcher = LocalDataFetcher()
    let localStorage: LocalStorageProtocol = LocalStorage()
    
    func getCrypto(completion: @escaping ([Crypto]) -> Void) {
        var cryptoArray = [Crypto]()
        let dispatchGroup = DispatchGroup()
        
        fetchStocks { crypto in
            crypto?.topCrypto.forEach { [weak self] topCrypto in
                dispatchGroup.enter()
                self?.fetchPrice(forTether: topCrypto.tether) { price in
                    
                    let crypto = Crypto(tether: topCrypto.tether,
                                        name: topCrypto.name,
                                        price: price?.correctPrice)
                
                    cryptoArray.append(crypto)
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(cryptoArray)
        }
    }
        
    func getPortfolioCrypto(savedCrypto: [PortfolioCryptoModel], completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        savedCrypto.forEach { savedCrypto in
            dispatchGroup.enter()
            fetchPrice(forTether: savedCrypto.tether) { cryptoPrice in
                guard let price = cryptoPrice?.correctPrice else {
                    self.localStorage.update {
                        savedCrypto.currentPrice.value = nil
                        }
                    return
                }
                
                self.localStorage.update {
                    savedCrypto.currentPrice.value = price
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func fetchStocks(completion: @escaping (CryptoData?) -> Void) {
        guard let path = Bundle.main.path(forResource: "crypto", ofType: "json") else { return }
        localDataFetcher.fetchJSONData(urlString: path, completion: completion)
    }
    
    private func fetchPrice(forTether tether: String, completion: @escaping (CryptoPriceData?) -> Void) {
        let urlString = "https://api.binance.com/api/v3/ticker/price?symbol=\(tether)USDT"
        networkDataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
}

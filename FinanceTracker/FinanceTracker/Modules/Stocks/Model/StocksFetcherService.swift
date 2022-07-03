//
//  StocksFetcherService.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 06.02.2022.
//

import Foundation

class StocksFetcherService {
    let localDataFetcher = LocalDataFetcher()
    let networkDataFetcher = NetworkDataFetcher()
    let localStorage: LocalStorageProtocol = LocalStorage()
    
    func getStock(completion: @escaping ([Stock]) -> Void) {
        var stocksArray = [Stock]()
        let dispatchGroup = DispatchGroup()
        
        fetchStocks { stocks in
            stocks?.topStocks.forEach { [weak self] topStock in
                dispatchGroup.enter()
                self?.fetchPrice(forTicker: topStock.ticker) { stockPrice in
                
                    let stock = Stock(ticker: topStock.ticker,
                                      companyName: topStock.companyName,
                                      currency: topStock.correctCurrency,
                                      price: stockPrice?.correctPrice ?? 0)
                    stocksArray.append(stock)
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(stocksArray)
        }
    }
    
    func portfolioStock(savedStocks: [PortfolioStockModel], completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        savedStocks.forEach { savedStock in
            dispatchGroup.enter()
            fetchPrice(forTicker: savedStock.ticker) { stockPrice in
                guard let price = stockPrice?.correctPrice else {
                    self.localStorage.update {
                        savedStock.currentPrice.value = nil
                        }
                    return
                }
                
                self.localStorage.update {
                    savedStock.currentPrice.value = price
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func fetchPrice(forTicker ticker: String, completion: @escaping (StockPrice?) -> Void) {
        let apiKey = APIKey.twelveDataKeys.randomElement()!
        let urlString = "https://api.twelvedata.com/price?symbol=\(ticker)&apikey=\(apiKey)"
        networkDataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    
    private func fetchStocks(completion: @escaping (StocksData?) -> Void) {
        guard let path = Bundle.main.path(forResource: "stocks", ofType: "json") else { return }
        localDataFetcher.fetchJSONData(urlString: path, completion: completion)
    }
}

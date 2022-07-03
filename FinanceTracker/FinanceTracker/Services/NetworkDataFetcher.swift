//
//  NetworkDataFetcher.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 06.02.2022.
//

import Foundation

class NetworkDataFetcher: DataFetchable {
    var networkService = NetworkService()
    var dataDecoder = DataDecoder()
    
    func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (T?) -> Void) {
        networkService.request(urlString: urlString) { data, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            let decoded = self.dataDecoder.decodeJSON(type: T.self, data: data)
            completion(decoded)
        }
    }
}

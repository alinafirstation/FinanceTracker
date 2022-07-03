//
//  LocalDataFetcher.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 06.02.2022.
//

import Foundation

class LocalDataFetcher: DataFetchable {
    var dataDecoder = DataDecoder()
    
    func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (T?) -> Void) {
        let url = URL(fileURLWithPath: urlString)
        let data = try? Data(contentsOf: url)
        let decoded = self.dataDecoder.decodeJSON(type: T.self, data: data)
        completion(decoded)
    }
}

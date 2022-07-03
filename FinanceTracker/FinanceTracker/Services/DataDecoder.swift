//
//  DataDecoder.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 06.02.2022.
//

import Foundation

class DataDecoder {
    func decodeJSON<T: Codable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type, from: data)
            return objects
        } catch { }
        
        return nil
    }
}

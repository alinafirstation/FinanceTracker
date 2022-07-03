//
//  DataFetchable.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 06.02.2022.
//

import Foundation

protocol DataFetchable {
    func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (T?) -> Void)
}

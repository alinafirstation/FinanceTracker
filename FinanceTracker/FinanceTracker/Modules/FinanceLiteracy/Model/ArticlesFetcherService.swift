//
//  ArticlesFetcherService.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.03.2022.
//

import Foundation

class ArticlesFetcherService {
    let localDataFetcher = LocalDataFetcher()
    
    func fetchBlocks(completion: @escaping ([EducationPreview]?) -> Void) {
        guard let path = Bundle.main.path(forResource: "articles", ofType: "json") else { return }
        localDataFetcher.fetchJSONData(urlString: path, completion: completion)
    }
}


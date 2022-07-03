//
//  ArticlesData.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.03.2022.
//

import Foundation

struct EducationPreview: Codable {
    let image: String
    let title: String
    let articles: [ArticleBlock]
}

struct ArticleBlock: Codable {
    let previewImage: String
    let title: String
    let article: [Article]
}

struct Article: Codable {
    let type: String
    let content: String
}

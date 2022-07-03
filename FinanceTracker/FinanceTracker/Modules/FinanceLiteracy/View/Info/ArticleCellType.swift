//
//  ArticleCellType.swift
//  Track Finance
//
//  Created by Alina on 28.03.2022.
//

import Foundation

enum ArticleCellType: String, CaseIterable {
    case image
    case title
    case text
    
    static var numberOfRows: Int {
        return self.allCases.count
    }
    
    static func getRow(_ row: Int) -> ArticleCellType {
        self.allCases[row]
    }
}

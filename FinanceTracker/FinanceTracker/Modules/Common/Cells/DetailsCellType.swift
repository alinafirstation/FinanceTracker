//
//  DetailsCellType.swift
//  Track Finance
//
//  Created by Alina on 08.04.2022.
//

import Foundation

enum DetailsCellType: Int, CaseIterable {
    case price
    case parameters
    
    static var numberOfRows: Int {
        return self.allCases.count
    }
    
    static func getRow(_ row: Int) -> DetailsCellType {
        self.allCases[row]
    }
}

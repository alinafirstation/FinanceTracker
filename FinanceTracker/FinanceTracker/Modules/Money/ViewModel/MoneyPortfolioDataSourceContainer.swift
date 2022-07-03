//
//  MoneyPortfolioDataSourceContainer.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.04.2022.
//

import Foundation

enum MoneyPortfolioDataSourceContainer {
    case classification(ReusableTableContainerViewModel<MoneyClassificationView>)
    case mainInfo(ReusableTableContainerViewModel<MoneyPortfolioInfoView>)
}

//
//  MoneyPortfolioDataSourceFactory.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.04.2022.
//

import Foundation

struct MoneyPortfolioDataSourceFactoryParams {
    let savedMoney: [PortfolioMoneyModel]
    let selectedType: MoneyClassification
    weak var moneyClassificationDelegate: MoneyClassificationViewDelegate?
}

final class MoneyPortfolioDataSourceFactory {
    func createDataSource(withParams params: MoneyPortfolioDataSourceFactoryParams) -> [MoneyPortfolioDataSourceContainer] {
        var cellsContainer: [MoneyPortfolioDataSourceContainer] = []
        cellsContainer.append(createClassificationViewModel(params: params))
        cellsContainer.append(contentsOf: createMainInfoViewModel(params: params))
        return cellsContainer
    }
    
    private func createClassificationViewModel(params: MoneyPortfolioDataSourceFactoryParams) -> MoneyPortfolioDataSourceContainer {
        let moneyViewModel = MoneyClassificationViewModel(selectedType: params.selectedType, firstTitle: MoneyClassification.income.title, secondTitle: MoneyClassification.expenses.title, delegate: params.moneyClassificationDelegate)
        let cellViewModel = ReusableTableContainerViewModel<MoneyClassificationView>(viewModel: moneyViewModel)
        
        return .classification(cellViewModel)
    }
    
    private func createMainInfoViewModel(params: MoneyPortfolioDataSourceFactoryParams) -> [MoneyPortfolioDataSourceContainer] {
        var container: [MoneyPortfolioDataSourceContainer] = []
        
        params.savedMoney.forEach {
            let infoViewModel = MoneyPortfolioInfoViewModel(imageName: $0.imageName, category: $0.category, date: $0.date, sum: String.currencyFormatter($0.sum))
            let cellContainerViewModel = ReusableTableContainerViewModel<MoneyPortfolioInfoView>(viewModel: infoViewModel)
            container.append(.mainInfo(cellContainerViewModel))
        }
        
        return container
    }
}

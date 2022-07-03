//
//  StatisticsDataSourceFactory.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 08.05.2022.
//

import Foundation

final class StatisticsDataSourceFactory {
    func createStatistics() -> [StatisticsDataSourceContainer] {
        var cellContainer: [StatisticsDataSourceContainer] = []

        cellContainer.append(createChart())
        cellContainer.append(contentsOf: createStatisticsInfoViewModel())

        return cellContainer
    }

    private func createStatisticsInfoViewModel() -> [StatisticsDataSourceContainer] {
        var container: [StatisticsDataSourceContainer] = []

        StatisticsType.allCases.forEach {
            let statisticsMainInfoViewModel = StatisticsMainInfoViewModel(title: $0.title, sumInfo: $0.sum, profit: $0.profit)
            let reusableContainerViewModel = ReusableTableContainerViewModel<StatisticsMainInfoView>(viewModel: statisticsMainInfoViewModel)

            container.append(.statisticsInfo(reusableContainerViewModel))
        }

        return container
    }

    private func createChart() -> StatisticsDataSourceContainer {
        let reusableContainerViewModel = ReusableTableContainerViewModel<StatisticsChartView>(viewModel: StatisticsChartViewModel())
        return .chart(reusableContainerViewModel)
    }
}

enum StatisticsType: CaseIterable {
    case stock
    case crypto
    case money
    case all

    var title: String {
        switch self {
        case .stock:
            return "АКЦИИ"
        case .crypto:
            return "КРИПТОВАЛЮТА"
        case .money:
            return "ДЕНЬГИ"
        case .all:
            return "ВСЕГО"
        }
    }
    
    var sum: String {
        switch self {
        case .stock:
            return "5548 ₽"
        case .crypto:
            return "12399 ₽"
        case .money:
            return "10287 ₽"
        case .all:
            return "28234 ₽"
        }
    }
    
    var profit: String {
        switch self {
        case .stock:
            return "+1203 ₽ (21%)"
        case .crypto:
            return "+3400 ₽ (27%)"
        case .money:
            return "-1320 ₽ (13%)"
        case .all:
            return "+3283 ₽ (35%)"
        }
    }
}

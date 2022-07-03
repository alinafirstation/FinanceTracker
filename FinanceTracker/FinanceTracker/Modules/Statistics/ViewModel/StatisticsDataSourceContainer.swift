//
//  StatisticsDataSourceContainer.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 08.05.2022.
//

import UIKit

enum StatisticsDataSourceContainer {
    case chart(ReusableTableContainerViewModel<StatisticsChartView>)
    case statisticsInfo(ReusableTableContainerViewModel<StatisticsMainInfoView>)
}

//
//  MoneyDetailsType.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import Foundation

enum MoneyDetailDataSourceContainer {
    case classification(ReusableTableContainerViewModel<MoneyClassificationView>)
    case imageSelector(ReusableTableContainerViewModel<MoneyDetailsImageSelectorView>)
    case details(ReusableTableContainerViewModel<ParametersView>)
}

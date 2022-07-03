//
//  MoneyDetailsDataSourceFactory.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import Foundation

struct MoneyDetailDataSourceFactoryParams {
    let selectedType: MoneyClassification
    let selectedImageIndex: Int
    weak var moneyClassificationDelegate: MoneyClassificationViewDelegate?
    weak var selectedImageDelegate: MoneyDetailsImageSelectorViewDelegate?
    weak var detailsDelegate: ParametersViewDelegate?
}

final class MoneyDetailDataSourceFactory {
    func createDataSource(params: MoneyDetailDataSourceFactoryParams) -> [MoneyDetailDataSourceContainer] {
        var cellContainer: [MoneyDetailDataSourceContainer] = []
        
        cellContainer.append(createClassificationViewModel(params: params))
        cellContainer.append(createImageSelectorViewModel(params: params))
        cellContainer.append(createDetailsView(params: params))
        return cellContainer
    }
    
    private func createClassificationViewModel(params: MoneyDetailDataSourceFactoryParams) -> MoneyDetailDataSourceContainer {
        let moneyViewModel = MoneyClassificationViewModel(selectedType: params.selectedType, firstTitle: MoneyClassification.income.title, secondTitle: MoneyClassification.expenses.title, delegate: params.moneyClassificationDelegate)
        let cellViewModel = ReusableTableContainerViewModel<MoneyClassificationView>(viewModel: moneyViewModel)
        
        return .classification(cellViewModel)
    }
    
    private func createImageSelectorViewModel(params: MoneyDetailDataSourceFactoryParams) -> MoneyDetailDataSourceContainer {
        var imageContainer: [ReusableCollectionContainerCellViewModel<ImageView>] = []
        
        
        let expense = MoneyImageType.Expense.allCases
        let income = MoneyImageType.Income.allCases
        if params.selectedType == .income {
            income.enumerated().forEach { index, item in
                imageContainer.append(setupImageContainer(withName: item.rawValue, isActive: index == params.selectedImageIndex))
            }
        } else {
            expense.enumerated().forEach { index, item in
                imageContainer.append(setupImageContainer(withName: item.rawValue, isActive: index == params.selectedImageIndex))
            }
        }
        
        let infoViewModel = MoneyDetailsImageSelectorViewModel(imageViewModels: imageContainer, delegate: params.selectedImageDelegate)
        let cellViewModel = ReusableTableContainerViewModel<MoneyDetailsImageSelectorView>(viewModel: infoViewModel)
        return .imageSelector(cellViewModel)
    }
    
    private func createDetailsView(params: MoneyDetailDataSourceFactoryParams) -> MoneyDetailDataSourceContainer {
        let paramsViewModel = ParametersViewModel(type: .money, actionDelegate: params.detailsDelegate)
        let cellViewModel = ReusableTableContainerViewModel<ParametersView>(viewModel: paramsViewModel)
        return .details(cellViewModel)
    }
    
    private func setupImageContainer(withName name: String, isActive: Bool) -> ReusableCollectionContainerCellViewModel<ImageView> {
        let imageViewModel = ImageViewModel(imageName: "Money/\(name)", isActive: isActive)
        let imageViewModelContainer = ReusableCollectionContainerCellViewModel<ImageView>(viewModel: imageViewModel)
        return imageViewModelContainer
    }
}


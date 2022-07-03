//
//  ReusableCollectionContainerCellViewModel.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

struct ReusableCollectionContainerCellViewModel<View: UIView & ViewModelSettable> {
    typealias CellType = ReusableCollectionContainerCell<View>
    typealias ViewModel = View.ViewModel
    let viewModel: View.ViewModel

    init(viewModel: View.ViewModel) {
        self.viewModel = viewModel
    }
}

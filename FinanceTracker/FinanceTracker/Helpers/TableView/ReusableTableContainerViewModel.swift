//
//  ReusableTableContainerViewModel.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

struct ReusableTableContainerViewModel<View: UIView & ViewModelSettable> {
    typealias CellType = ReusableTableContainerCell<View>
    typealias ViewModel = View.ViewModel
    let viewModel: View.ViewModel
    let selectionStyle: UITableViewCell.SelectionStyle

    init(viewModel: View.ViewModel, selectionStyle: UITableViewCell.SelectionStyle = .none) {
        self.viewModel = viewModel
        self.selectionStyle = selectionStyle
    }
}

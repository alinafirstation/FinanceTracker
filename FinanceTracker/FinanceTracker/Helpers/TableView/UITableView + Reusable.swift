//
//  UITableView + Reusable.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

extension UITableView {
    func dequeueReusableCellWithViewModel<View: UIView & ViewModelSettable>(viewModel: ReusableTableContainerViewModel<View>) -> ReusableTableContainerViewModel<View>.CellType {
        let id = String(describing: ReusableTableContainerViewModel<View>.CellType.self)
        if let cell = dequeueReusableCell(withIdentifier: id) as? ReusableTableContainerViewModel<View>.CellType {
            cell.setup(with: viewModel)
            return cell
        } else {
            register(ReusableTableContainerViewModel<View>.CellType.self, forCellReuseIdentifier: id)
            return dequeueReusableCellWithViewModel(viewModel: viewModel)
        }
    }
}

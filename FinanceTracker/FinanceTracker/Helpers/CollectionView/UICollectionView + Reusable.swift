//
//  UICollectionView + Reusable.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

extension UICollectionView {
    func registerCell(type: UICollectionViewCell.Type) {
        let id = String(describing: type)
        register(type, forCellWithReuseIdentifier: id)
    }
    
    func dequeueReusableCellWithViewModel<View: UIView & ViewModelSettable>(
        viewModel: ReusableCollectionContainerCellViewModel<View>,
        indexPath: IndexPath
    ) -> ReusableCollectionContainerCellViewModel<View>.CellType {
        let id = String(describing: ReusableCollectionContainerCellViewModel<View>.CellType.self)
        registerCell(type: ReusableCollectionContainerCellViewModel<View>.CellType.self)
        if let cell = dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? ReusableCollectionContainerCellViewModel<View>.CellType {
            cell.setup(with: viewModel)
            return cell
        } else {
            assertionFailure("Could not dequeue cell with reuseId \(id)")
            return ReusableCollectionContainerCellViewModel<View>.CellType()
        }
    }
}

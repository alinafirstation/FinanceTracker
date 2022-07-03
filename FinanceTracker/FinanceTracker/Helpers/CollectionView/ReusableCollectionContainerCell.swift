//
//  ReusableCollectionContainerCell.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

final class ReusableCollectionContainerCell<View: ViewModelSettable & UIView>: UICollectionViewCell, ViewModelSettable {

    private let mainView = View(frame: .zero)
    private let animationDuration = 0.2
    private let transformScale: CGFloat = 1.05

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        contentView.addSubviewWithConstraints(mainView)
    }

    func scale(with delay: Double) {
        UIView.animate(
            withDuration: animationDuration,
            delay: delay,
            animations: {
                self.mainView.transform = .init(scaleX: self.transformScale, y: self.transformScale)
            },
            completion: { _ in
                self.mainView.transform = .identity
            }
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        mainView.prepareForReuse()
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return mainView.becomeFirstResponder()
    }

    func setup(with viewModel: ReusableCollectionContainerCellViewModel<View>) {
        mainView.setup(with: viewModel.viewModel)
    }
}

//
//  ReusableTableContainerCell.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

final class ReusableTableContainerCell<View: ViewModelSettable & UIView>: UITableViewCell, ViewModelSettable {
    private let mainView = View(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        contentView.addSubviewWithConstraints(mainView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.prepareForReuse()
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return mainView.becomeFirstResponder()
    }

    func setup(with viewModel: ReusableTableContainerViewModel<View>) {
        selectionStyle = viewModel.selectionStyle
        mainView.setup(with: viewModel.viewModel)
    }
}

extension UIView {
    func addSubviewWithConstraints(_ subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: [], metrics: nil, views: ["subview": subview]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: [], metrics: nil, views: ["subview": subview]))
    }
}

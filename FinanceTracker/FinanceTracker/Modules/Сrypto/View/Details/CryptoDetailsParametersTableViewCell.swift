//
//  CryptoDetailsParametersTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 08.04.2022.
//

import UIKit
import SnapKit

class CryptoDetailsParametersTableViewCell: UITableViewCell {
    weak var actionDelegate: ParametersViewDelegate?
    private let parametersView = ParametersView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(parametersView)
        contentView.backgroundColor = .material
    }
    
    private func setupConstraints() {
        parametersView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupViewModel() {
        let viewModel = ParametersViewModel(type: .crypto, actionDelegate: actionDelegate)
        parametersView.setupViewParameters(with: viewModel)
    }
}



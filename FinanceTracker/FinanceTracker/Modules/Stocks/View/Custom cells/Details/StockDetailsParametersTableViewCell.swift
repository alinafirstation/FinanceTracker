//
//  StockDetailsParametersTableViewCell.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 07.03.2022.
//

import UIKit
import SnapKit

class StockDetailsParametersTableViewCell: UITableViewCell {
    weak var actionDelegate: ParametersViewDelegate?
    private let parametersView = ParametersView()
    
    private var purchasePrice: Double?
    private var lots: Int?
    private var date: String?
    
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
        let viewModel = ParametersViewModel(type: .stocks, actionDelegate: actionDelegate)
        parametersView.setupViewParameters(with: viewModel)
    }
}

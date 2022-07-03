//
//  CryptoHistoryTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 12.04.2022.
//

import UIKit

class CryptoHistoryTableViewCell: UITableViewCell {
    private lazy var descriptionPlaceHolder: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 16)
        
        return label
    }()
    
    private lazy var addedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 16)
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 16)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: PurchaseCrypto) {
        let description = model.historyType == .add
        ? Localization.Common.addDescriptionPlaceHolder.rawValue
        : Localization.Common.removeDescriptionPlaceHolder.rawValue
        
        let price = model.purchasePrice > 0
        ? String.currencyFormatter(model.purchasePrice)
        : ""
        
        descriptionPlaceHolder.text = description + " (\(model.amount) шт)"
        addedDateLabel.text = model.date
        priceLabel.text = price
    }
    
    private func setupCell() {
        contentView.backgroundColor = .material
        contentView.addSubview(descriptionPlaceHolder)
        contentView.addSubview(addedDateLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        descriptionPlaceHolder.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        addedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionPlaceHolder.snp.bottom).inset(-15)
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(descriptionPlaceHolder.snp.leading)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}


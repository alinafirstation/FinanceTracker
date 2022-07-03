//
//  CryptoPortfolioTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 12.04.2022.
//

import UIKit
import Kingfisher

class CryptoPortfolioTableViewCell: CryptoCommonTableViewCell {
    private let loaderView = LoaderView()
    
    private lazy var profitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = AppFont.font(type: .Bold, size: 12)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        priceLabel.text = nil
        profitLabel.text = nil
        profitLabel.textColor = nil
        iconImageView.kf.cancelDownloadTask()
        iconImageView.image = nil
    }
    
    override func setupCell() {
        super.setupCell()
        
        contentView.addSubview(profitLabel)
        contentView.addSubview(loaderView)
    }
    
    func configureCell(with model: PortfolioCryptoModel) {
        nameLabel.text = model.name
        symbolLabel.text = "\(model.tether) (\(model.amount.trailingZero) шт)"
        
        guard let cryptoPriceAmount = model.amountPrice,
              let profitPercentage = model.profitPercentage,
              let profitMoney = model.profitMoney else {
                  loaderView.isHidden = false
                  return
              }

        loaderView.isHidden = true

        priceLabel.text = String.currencyFormatter(cryptoPriceAmount)

        if profitPercentage < 0 {
            profitLabel.textColor = .red
            profitLabel.text = String.currencyFormatter(profitMoney) + " (\(profitPercentage.trailingZero) %)"
        } else {
            profitLabel.textColor = .green
            profitLabel.text = "+" + String.currencyFormatter(profitMoney) + " (\(profitPercentage.trailingZero) %)"
        }
        iconImageView.image = UIImage(named: "Crypto/\(model.tether)")
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(40).priority(.high)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-16)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.trailing.equalToSuperview().inset(20)
        }
        
        profitLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(symbolLabel.snp.top)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        loaderView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(28)
        }
    }
}


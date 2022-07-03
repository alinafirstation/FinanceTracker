//
//  StockPortfolioTableViewCell.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 20.03.2022.
//

import UIKit

class StockPortfolioTableViewCell: StockCommonTableViewCell {
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
    }
    
    override func setupCell() {
        super.setupCell()
        
        contentView.addSubview(profitLabel)
        contentView.addSubview(loaderView)
    }
    
    func configureCell(with model: PortfolioStockModel) {
        iconImageView.image = UIImage(named: "Stocks/\(model.ticker)")
        companyNameLabel.text = model.companyName
        tickerLabel.text = "\(model.ticker) (\(model.lots) шт)"
        
        guard let stockPriceAmount = model.amountPrice,
              let profitPercentage = model.profitPercentage,
              let profitMoney = model.profitMoney else {
                  loaderView.isHidden = false
                  return
              }

        loaderView.isHidden = true
        priceLabel.text = String.currencyFormatter(stockPriceAmount)

        if profitPercentage < 0 {
            profitLabel.textColor = .red
            profitLabel.text = String.currencyFormatter(profitMoney) + " (\(profitPercentage.trailingZero) %)"
        } else {
            profitLabel.textColor = .green
            profitLabel.text = "+" + String.currencyFormatter(profitMoney) + " (\(profitPercentage.trailingZero) %)"
        }
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(40).priority(.high)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-16)
        }
        
        tickerLabel.snp.makeConstraints { make in
            make.leading.equalTo(companyNameLabel.snp.leading)
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.top)
            make.trailing.equalToSuperview().inset(20)
        }
        
        profitLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(tickerLabel.snp.top)
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

//
//  SearchStocksTableViewCell.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 06.02.2022.
//

import UIKit

class SearchStocksTableViewCell: StockCommonTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(withModel model: Stock) {
        iconImageView.image = UIImage(named: "Stocks/\(model.ticker)")
        companyNameLabel.text = model.companyName
        tickerLabel.text = model.ticker
        priceLabel.text = String.currencyFormatter(model.price)
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(40)
        }
        
        companyNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-16)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).inset(-16)
        }
        
        tickerLabel.snp.makeConstraints { make in
            make.leading.equalTo(companyNameLabel.snp.leading)
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

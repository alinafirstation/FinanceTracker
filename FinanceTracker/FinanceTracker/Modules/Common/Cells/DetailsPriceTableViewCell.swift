//
//  DetailsPriceTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 08.04.2022.
//

import UIKit
import Kingfisher

class DetailsPriceTableViewCell: UITableViewCell {
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = AppFont.font(type: .Bold, size: 28)
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .material
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(iconImageView.snp.leading).inset(-16)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(40).priority(.high)
        }
    }

    func configureCell(with model: Stock) {
        priceLabel.text = String.currencyFormatter(model.price)
        iconImageView.image = UIImage(named: "Stocks/\(model.ticker)")
    }
    
    func configureCell(with model: Crypto) {
        guard let correctPrice = model.price else { return }
        
        priceLabel.text = String.currencyFormatter(correctPrice)
        iconImageView.image = UIImage(named: "Crypto/\(model.tether)")
    }
}


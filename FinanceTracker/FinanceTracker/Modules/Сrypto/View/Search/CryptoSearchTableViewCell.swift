//
//  CryptoSearchTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 06.04.2022.
//

import UIKit
import Kingfisher

class CryptoSearchTableViewCell: CryptoCommonTableViewCell {
    
    private let loaderView = LoaderView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    override func setupCell() {
        super.setupCell()
        contentView.addSubview(loaderView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.kf.cancelDownloadTask()
        iconImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(withModel model: Crypto) {
        nameLabel.text = model.name
        symbolLabel.text = model.tether
        iconImageView.image = UIImage(named: "Crypto/\(model.tether)")
        
        guard let correctPrice = model.price else {
            loaderView.isHidden = false
            return
        }
        
        loaderView.isHidden = true
        priceLabel.text = String.currencyFormatter(correctPrice)
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
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
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
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


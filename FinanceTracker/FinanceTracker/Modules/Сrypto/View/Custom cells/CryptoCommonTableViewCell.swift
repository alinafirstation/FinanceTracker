//
//  CryptoCommonTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 06.04.2022.
//

import UIKit

class CryptoCommonTableViewCell: UITableViewCell {
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 18)
        
        return label
    }()
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = AppFont.font(type: .Medium, size: 12)
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 16)
        
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        contentView.backgroundColor = .material
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(separatorView)
    }
}



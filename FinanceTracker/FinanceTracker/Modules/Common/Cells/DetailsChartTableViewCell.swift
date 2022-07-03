//
//  DetailsChartTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 08.04.2022.
//

import UIKit

class DetailsChartTableViewCell: UITableViewCell {
    private lazy var chartImage: UIImageView = {
        let image = UIImage(named: "chartTemp")
        let imageView = UIImageView(image: image)
        
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
        contentView.addSubview(chartImage)
    }
    
    private func setupConstraints() {
        chartImage.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200).priority(.high)
        }
    }
}

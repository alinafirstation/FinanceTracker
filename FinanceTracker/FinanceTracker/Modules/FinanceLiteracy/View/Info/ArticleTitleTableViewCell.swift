//
//  ArticleTitleTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 29.03.2022.
//

import UIKit

class ArticleTitleTableViewCell: UITableViewCell {
    private lazy var artTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 22)
        label.textAlignment = .left
        label.numberOfLines = 0
        
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
    
    private func setupCell() {
        contentView.backgroundColor = .material
        contentView.addSubview(artTitle)
    }
    
    private func setupConstraints() {
        artTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.leading.equalToSuperview().inset(10)
        }
    }

    func configureCell(title: String) {
        artTitle.text = title
    }
}

//
//  ArticleTextTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 29.03.2022.
//

import UIKit

class ArticleTextTableViewCell: UITableViewCell {
    private lazy var artText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Medium, size: 16)
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
        contentView.addSubview(artText)
        setupConstraints()
    }
    
    private func setupConstraints() {
        artText.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }

    func configureCell(text: String) {
        artText.text = text
    }
}

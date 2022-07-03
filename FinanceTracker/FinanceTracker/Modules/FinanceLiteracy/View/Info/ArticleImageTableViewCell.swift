//
//  ArticleImageTableViewCell.swift
//  Track Finance
//
//  Created by Alina on 28.03.2022.
//

import UIKit

class ArticleImageTableViewCell: UITableViewCell {
    private lazy var artImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
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
        contentView.addSubview(artImage)
    }
    
    private func setupConstraints() {
        artImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(160).priority(.high)
        }
    }
    
    func configureCell(image: String) {
        artImage.image = UIImage(named: "Articles/\(image)")
    }
}


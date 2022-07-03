//
//  ArticleCollectionViewCell.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.03.2022.
//

import UIKit
import SnapKit

class ArticleCollectionViewCell: UICollectionViewCell {
    private lazy var artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    private lazy var artName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 18)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: ArticleBlock) {
        artImageView.image = UIImage(named: "Articles/\(model.previewImage)")
        artName.text = model.title
    }
    
    func configureCell(model: EducationPreview) {
        artImageView.image = UIImage(named: "Articles/\(model.image)")
        artName.text = model.title
    }
    
    private func setupCell() {
        contentView.addSubview(artImageView)
        artImageView.addSubview(artName)
    }
    
    private func setupConstraints() {
        artImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        artName.snp.makeConstraints { make in
            make.bottom.equalTo(artImageView.snp.bottom).inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}

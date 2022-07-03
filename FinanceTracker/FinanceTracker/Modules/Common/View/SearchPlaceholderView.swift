//
//  SearchPlaceholderView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 10.03.2022.
//

import UIKit
import SnapKit

struct SearchPlaceholderViewModel {
    let image: String
    let title: String
}

class SearchPlaceholderView: UIView {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    init(viewModel: SearchPlaceholderViewModel) {
        super.init(frame: .zero)
        
        self.iconImageView.image = UIImage(named: viewModel.image)
        self.infoLabel.text = viewModel.title
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(iconImageView)
        addSubview(infoLabel)
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

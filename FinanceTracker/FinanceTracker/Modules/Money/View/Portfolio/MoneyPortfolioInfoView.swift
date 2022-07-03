//
//  MoneyPortfolioInfoView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.04.2022.
//

import UIKit

struct MoneyPortfolioInfoViewModel {
    let imageName: String
    let category: String
    let date: String
    let sum: String
}

final class MoneyPortfolioInfoView: UIView {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 18)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = AppFont.font(type: .Medium, size: 12)
        
        return label
    }()
    
    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 16)
        
        return label
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [iconImageView, categoryLabel, dateLabel, sumLabel, separatorView].forEach {
            addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(40)
        }
        
        categoryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-16)
            make.trailing.lessThanOrEqualTo(sumLabel.snp.leading).inset(-16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.leading)
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        sumLabel.snp.makeConstraints { make in
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

extension MoneyPortfolioInfoView: ViewModelSettable {
    func setup(with viewModel: MoneyPortfolioInfoViewModel) {
        iconImageView.image = UIImage(named: "Money/\(viewModel.imageName)")
        categoryLabel.text = viewModel.category
        dateLabel.text = viewModel.date
        sumLabel.text = viewModel.sum
    }
}

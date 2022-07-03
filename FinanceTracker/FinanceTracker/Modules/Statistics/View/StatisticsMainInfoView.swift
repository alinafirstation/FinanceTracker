//
//  StatisticsMainInfoView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 08.05.2022.
//

import UIKit

struct StatisticsMainInfoViewModel {
    let title: String
    let sumInfo: String
    let profit: String
}

class StatisticsMainInfoView: UIView {
    private let substrateView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .Bold, size: 16)

        return label
    }()

    private let sumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .SemiBold, size: 16)

        return label
    }()

    private let profitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.font(type: .SemiBold, size: 16)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(substrateView)
        substrateView.backgroundColor = .statisticsColor
        substrateView.addSubview(titleLabel)
        substrateView.addSubview(sumLabel)
        substrateView.addSubview(profitLabel)

        substrateView.layer.cornerRadius = 15
//        substrateView.layer.borderWidth = 2
//        substrateView.layer.borderColor = UIColor.black.cgColor

        setupConstraints()
    }

    private func setupConstraints() {
        substrateView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(sumLabel.snp.top).offset(-8)
        }

        sumLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }

        profitLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }

        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        sumLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        profitLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

extension StatisticsMainInfoView: ViewModelSettable {
    func setup(with viewModel: StatisticsMainInfoViewModel) {
        titleLabel.text = viewModel.title
        sumLabel.text = viewModel.sumInfo
        profitLabel.text = viewModel.profit
    }
}

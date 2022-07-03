//
//  MoneyClassificationView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

enum MoneyClassification: String, CaseIterable {
    case income
    case expenses
    
    var title: String {
        switch self {
        case .income:
            return "Доходы"
        case .expenses:
            return "Расходы"
        }
    }
}

struct MoneyClassificationViewModel {
    let selectedType: MoneyClassification
    let firstTitle: String
    let secondTitle: String
    weak var delegate: MoneyClassificationViewDelegate?
}

protocol MoneyClassificationViewDelegate: AnyObject {
    func classificationButtonTapped(at type: MoneyClassification)
}
    
final class MoneyClassificationView: UIView {
    weak var delegate: MoneyClassificationViewDelegate?
    
    private var incomeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.material, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.titleLabel?.font = AppFont.font(type: .Medium, size: 16)
        button.addTarget(self, action: #selector(incomeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var expensesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.material, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.titleLabel?.font = AppFont.font(type: .Medium, size: 16)
        button.addTarget(self, action: #selector(expenseButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView()
        [incomeButton, expensesButton].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(Constants.buttonHeight).priority(.high)
        }
    }
    
    @objc private func incomeButtonTapped() {
        delegate?.classificationButtonTapped(at: .income)
    }
    
    @objc private func expenseButtonTapped() {
        delegate?.classificationButtonTapped(at: .expenses)
    }
}

extension MoneyClassificationView: ViewModelSettable {
    func setup(with viewModel: MoneyClassificationViewModel) {
        incomeButton.setTitle(viewModel.firstTitle, for: .normal)
        expensesButton.setTitle(viewModel.secondTitle, for: .normal)
        delegate = viewModel.delegate
        
        switch viewModel.selectedType {
        case .income:
            incomeButton.backgroundColor = .accentColorHeavy
            expensesButton.backgroundColor = .gray.withAlphaComponent(0.6)
        case .expenses:
            incomeButton.backgroundColor = .gray.withAlphaComponent(0.6)
            expensesButton.backgroundColor = .accentColorHeavy
        }
    }
}

extension MoneyClassificationView {
    private struct Constants {
        static let buttonHeight: CGFloat = 44
        static let buttonCornerRadius: CGFloat = buttonHeight / 2
    }
}

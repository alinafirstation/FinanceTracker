//
//  ParametersView.swift
//  Track Finance
//
//  Created by Alina on 08.04.2022.
//

import UIKit

protocol ParametersViewDelegate: AnyObject {
    func addButtonDidTapped(with purchasePrice: Double,
                            lots: Int,
                            date: String)
    func addButtonDidTapped(with purchasePrice: Double,
                            amount: Double,
                            date: String)
    func addButtonDidTapped(with category: String,
                            sum: Double,
                            date: String)
    func showAlert()
}

extension ParametersViewDelegate {
    func addButtonDidTapped(with purchasePrice: Double,
                            lots: Int,
                            date: String) { }
    
    func addButtonDidTapped(with purchasePrice: Double,
                            amount: Double,
                            date: String) { }
    func addButtonDidTapped(with category: String,
                            sum: Double,
                            date: String) { }
}

struct ParametersViewModel {
    enum ViewType {
        case stocks
        case crypto
        case money
    }
    
    let type: ViewType
    weak var actionDelegate: ParametersViewDelegate?
}

class ParametersView: UIView {
    private weak var delegate: ParametersViewDelegate?
    
    private var category: String?
    private var purchasePrice: Double?
    private var lots: Double?
    private var date: String?
    
    private var viewType: ParametersViewModel.ViewType?
    
    private lazy var buyHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = AppFont.font(type: .Bold, size: 28)
        label.text = Localization.Common.buyHeaderLabel.rawValue
        
        return label
    }()
    
    private lazy var priceSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = AppFont.font(type: .Regular, size: 15)
        
        return label
    }()
    
    private lazy var purchasePriceTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.keyboardType = .decimalPad
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var lotsCountSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = AppFont.font(type: .Regular, size: 15)
        
        return label
    }()
    
    private lazy var lotsCountTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var dateSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = AppFont.font(type: .Regular, size: 15)
        label.text = Localization.Common.dateSubtitleLabel.rawValue
        
        return label
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.inputView = datePicker
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let today = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = today
        
        return datePicker
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .accentColorHeavy
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.material, for: .normal)
        button.titleLabel?.font = AppFont.font(type: .Medium, size: 18)
        button.layer.cornerRadius = Constants.addButtonCornerRadius
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewParameters(with viewModel: ParametersViewModel) {
        delegate = viewModel.actionDelegate
        
        switch viewModel.type {
        case .stocks:
            viewType = .stocks
            lotsCountTextField.keyboardType = .numberPad
            lotsCountSubtitleLabel.text = Localization.Stocks.History.lotsCountSubtitleLabel.rawValue
            priceSubtitleLabel.text =  Localization.Stocks.History.priceSubtitleLabel.rawValue
        case .crypto:
            viewType = .crypto
            lotsCountTextField.keyboardType = .decimalPad
            lotsCountSubtitleLabel.text = Localization.Crypto.History.lotsCountSubtitleLabel.rawValue
            priceSubtitleLabel.text =  Localization.Crypto.History.priceSubtitleLabel.rawValue
        case .money:
            viewType = .money
            purchasePriceTextField.keyboardType = .default
            lotsCountTextField.keyboardType = .decimalPad
            priceSubtitleLabel.text = Localization.Money.Details.category.rawValue
            lotsCountSubtitleLabel.text = Localization.Money.Details.sum.rawValue
            dateSubtitleLabel.text = Localization.Money.Details.date.rawValue
        }
    }
    
    private func setupView() {
        addSubview(buyHeaderLabel)
        addSubview(priceSubtitleLabel)
        addSubview(purchasePriceTextField)
        addSubview(lotsCountSubtitleLabel)
        addSubview(lotsCountTextField)
        addSubview(dateSubtitleLabel)
        addSubview(dateTextField)
        addSubview(addButton)
        
        setupDatePicker()
        setupTextField(textFields: [purchasePriceTextField, lotsCountTextField, dateTextField])
    }
    
    private func setupDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolBar.setItems([cancel, flexSpace, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolBar
    }
    
    private func setupConstraints() {
        buyHeaderLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        priceSubtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(buyHeaderLabel.snp.bottom).inset(-10)
        }
        
        purchasePriceTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(priceSubtitleLabel.snp.bottom).inset(-9)
            make.height.equalTo(40)
        }
        
        lotsCountSubtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(purchasePriceTextField.snp.bottom).inset(-10)
        }
        
        lotsCountTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(lotsCountSubtitleLabel.snp.bottom).inset(-9)
            make.height.equalTo(40)
        }
        
        dateSubtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(lotsCountTextField.snp.bottom).inset(-10)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(dateSubtitleLabel.snp.bottom).inset(-9)
            make.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(75)
            make.top.equalTo(dateTextField.snp.bottom).inset(-25)
            make.height.equalTo(Constants.addButtonHeight)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setupTextField(textFields: [UITextField]) {
        textFields.forEach { textField in
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftViewMode = .always
        }
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func doneAction() {
        getDateFromPicker()
        cancel()
    }
    
    @objc private func cancel() {
        endEditing(true)
    }
    
    @objc private func addButtonTapped() {
        if viewType == .money {
            guard let category = category,
                  let lots = lots,
                  let date = date else {
                      delegate?.showAlert()
                      return
                  }
            delegate?.addButtonDidTapped(with: category, sum: lots, date: date)
        } else {
            guard let purchasePrice = purchasePrice,
                  let lots = lots,
                  let date = date else {
                      delegate?.showAlert()
                      return
                  }
            
            switch viewType {
            case .stocks:
                delegate?.addButtonDidTapped(with: purchasePrice,
                                             lots: Int(lots),
                                             date: date)
            case .crypto:
                delegate?.addButtonDidTapped(with: purchasePrice,
                                             amount: lots,
                                             date: date)
            default: break
            }
        }
    }
}

private extension ParametersView {
    struct Constants {
        static let addButtonHeight: CGFloat = 44
        static let addButtonCornerRadius: CGFloat = addButtonHeight / 2
    }
}

extension ParametersView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case purchasePriceTextField:
            if viewType == .money {
                category = text
            } else {
                guard let price = Double(text) else { return }
                self.purchasePrice = price
            }
        case lotsCountTextField:
            guard let lots = Double(text) else { return }
            self.lots = lots
        case dateTextField:
            self.date = text
        default:
            break
        }
    }
}

extension ParametersView: ViewModelSettable {
    func setup(with viewModel: ParametersViewModel) {
        setupViewParameters(with: viewModel)
    }
}

//
//  MoneyDetailsViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

class MoneyDetailsViewController: UIViewController {
    private let localStorage: LocalStorageProtocol = LocalStorage()
    private let factory = MoneyDetailDataSourceFactory()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .material
        
        return tableView
    }()
    
    private var dataSource: [MoneyDetailDataSourceContainer] = []
    
    private var moneyClassificationType: MoneyClassification = .income
    private var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        
        setupNavBar()
        setupConstraints()
        setupKeyboard()
        setupDataSource()
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem(title: "", image: nil, primaryAction: nil, menu: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.title = Localization.Money.moneyTitle.rawValue
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        hideKeyboardWhenTappedAround()
    }
    
    private func setupDataSource() {
        let factoryParams = MoneyDetailDataSourceFactoryParams(selectedType: moneyClassificationType, selectedImageIndex: selectedImageIndex, moneyClassificationDelegate: self, selectedImageDelegate: self, detailsDelegate: self)
        dataSource = factory.createDataSource(params: factoryParams)
    }
    
    @objc dynamic func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + tableView.rowHeight, right: 0)
        }
    }

    @objc dynamic func keyboardWillHide() {
        UIView.animate(withDuration: 0.2) {
            self.tableView.contentInset = .zero
        }
    }
}

extension MoneyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.row]
        
        switch cellType {
        case .classification(let viewModel):
            return tableView.dequeueReusableCellWithViewModel(viewModel: viewModel)
        case .imageSelector(let viewModel):
            return tableView.dequeueReusableCellWithViewModel(viewModel: viewModel)
        case .details(let viewModel):
            return tableView.dequeueReusableCellWithViewModel(viewModel: viewModel)
        }
    }
}

extension MoneyDetailsViewController: MoneyClassificationViewDelegate {
    func classificationButtonTapped(at type: MoneyClassification) {
        if moneyClassificationType != type {
            selectedImageIndex = 0
            moneyClassificationType = type
            setupDataSource()
            tableView.reloadData()
        }
    }
}

extension MoneyDetailsViewController: MoneyDetailsImageSelectorViewDelegate {
    func didSelectImage(atIndex index: Int) {
        selectedImageIndex = index
        setupDataSource()
        tableView.reloadData()
    }
}

extension MoneyDetailsViewController: ParametersViewDelegate {
    func showAlert() {
        present(title: "Некорректные данные", message: "Проверьте правильность заполнения ваших полей")
    }
    
    func addButtonDidTapped(with category: String, sum: Double, date: String) {
        let imageName = moneyClassificationType == .income
        ? MoneyImageType.Income.getType(for: selectedImageIndex).rawValue
        : MoneyImageType.Expense.getType(for: selectedImageIndex).rawValue
        let portfolioMoneyModel = PortfolioMoneyModel(type: moneyClassificationType, imageName: imageName, category: category, sum: sum, date: date)
        
        localStorage.write(portfolioMoneyModel)
        navigationController?.popToRootViewController(animated: true)
    }
}

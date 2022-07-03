//
//  MoneyPortfolioViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.03.2022.
//

import UIKit
import SnapKit

class MoneyPortfolioViewController: UIViewController {
    private let factory = MoneyPortfolioDataSourceFactory()
    private var dataSource: [MoneyPortfolioDataSourceContainer] = []
    private let localStorage: LocalStorageProtocol = LocalStorage()
    
    private var money: [PortfolioMoneyModel] {
        return localStorage.objects().reversed()
    }
    
    private var filteredMonney: [PortfolioMoneyModel] {
        return moneyClassificationType == .income
        ? money.filter { $0.type == .income }
        : money.filter { $0.type == .expenses }
    }
    
    private var moneyClassificationType: MoneyClassification = .income
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .material
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var placeholderView: SearchPlaceholderView = {
        let viewModel = SearchPlaceholderViewModel(image: Localization.Money.moneyPlaceHolderImage.rawValue,
                                                   title: Localization.Money.moneyPlaceHolderTitle.rawValue)
        let view = SearchPlaceholderView(viewModel: viewModel)
        view.isHidden = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupDataSource()
    }
    
    private func setupView() {
        view.backgroundColor = .material
        view.addSubview(tableView)
        view.addSubview(placeholderView)
        
        navigationController?.setupNavigationController()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        placeholderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDataSource() {
        if money.count > 0 {
            tableView.isHidden = false
            placeholderView.isHidden = true
            
            let factoryParams = MoneyPortfolioDataSourceFactoryParams(savedMoney: filteredMonney, selectedType: moneyClassificationType, moneyClassificationDelegate: self)
            dataSource = factory.createDataSource(withParams: factoryParams)
            tableView.reloadData()
        } else {
            tableView.isHidden = true
            placeholderView.isHidden = false
        }
    }
    
    @objc private func addButtonTapped() {
        let moneyDetails = MoneyDetailsViewController()
        navigationController?.pushViewController(moneyDetails, animated: true)
    }
}

extension MoneyPortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.row]
        
        switch cellType {
        case .classification(let viewModel):
            return tableView.dequeueReusableCellWithViewModel(viewModel: viewModel)
        case .mainInfo(let viewModel):
            return tableView.dequeueReusableCellWithViewModel(viewModel: viewModel)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        } else {
            return true
        }
    }
}

extension MoneyPortfolioViewController: MoneyClassificationViewDelegate {
    func classificationButtonTapped(at type: MoneyClassification) {
        if moneyClassificationType != type {
            moneyClassificationType = type
            setupDataSource()
        }
    }
}


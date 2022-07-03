//
//  CryptoPortfolioViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 30.01.2022.
//

import UIKit
import SnapKit

class CryptoPortfolioViewController: UIViewController {
    private let cryptoFetcherService = CryptoFetcherService()
    private let localStorage: LocalStorageProtocol = LocalStorage()
    
    private var crypto: [PortfolioCryptoModel] {
        return localStorage.objects().reversed()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .material
        tableView.registerReusableCell(CryptoPortfolioTableViewCell.self)
        tableView.isHidden = true
        
        return tableView
    }()
    
    private lazy var placeholderView: SearchPlaceholderView = {
        let viewModel = SearchPlaceholderViewModel(image: Localization.Crypto.cryptoPlaceHolderImage.rawValue,
                                                   title: Localization.Crypto.cryptoPlaceHolderTitle.rawValue)
        let view = SearchPlaceholderView(viewModel: viewModel)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViewState()
    }
    
    private func updateViewState() {
        if crypto.count > 0 {
            tableView.isHidden = false
            placeholderView.isHidden = true
            updatePortfolio()
        } else {
            tableView.isHidden = true
            placeholderView.isHidden = false
        }
    }
    
    private func updatePortfolio() {
        cryptoFetcherService.getPortfolioCrypto(savedCrypto: crypto) { [weak self] in
            self?.tableView.reloadData()
        }
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
    
    @objc private func addButtonTapped() {
        let searchCryptoVC = CryptoSearchViewController()
        navigationController?.pushViewController(searchCryptoVC, animated: true)
    }
}

extension CryptoPortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crypto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CryptoPortfolioTableViewCell
        cell.configureCell(with: crypto[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crypto = crypto[indexPath.row]
        let viewController = CryptoHistoryViewController(symbol: crypto.tether)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let crypto = crypto[indexPath.row]
        let symbol = crypto.tether
        
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, _) in
            guard let model: PortfolioCryptoModel = self.localStorage.object(symbol) else { return }
            
            model.historyPurchaseCrypto.forEach { self.localStorage.delete($0)}
            self.localStorage.delete(model)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateViewState()
        }
        
        let edit = UIContextualAction(style: .normal, title: "Изменить") { (_, _, _) in
            guard let model: PortfolioCryptoModel = self.localStorage.object(symbol) else { return }
            
            let alert = UIAlertController(title: "Редактирование", message: "Уменьшите количество активов", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = "\(crypto.amount)"
                textField.keyboardType = .decimalPad
            }
            
            let cancel = UIAlertAction(title: "Отменить", style: .cancel)
            let edit = UIAlertAction(title: "Изменить", style: .default) { _ in
                guard let text = alert.textFields?[0].text,
                      !text.isEmpty, let lots = Double(text),
                      lots < crypto.amount,
                      lots > 0 else { return }
                self.localStorage.update {
                    let history = PurchaseCrypto(historyType: .remove, purchasePrice: 0, amount: model.amount - lots, date: Date().toString())
                    model.amount = lots
                    model.historyPurchaseCrypto.append(history)
                }
                self.updateViewState()
            }
            
            alert.addAction(edit)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [edit, delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

//
//  StocksPortfolioViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 30.01.2022.
//

import UIKit
import SnapKit
import RealmSwift

class StocksPortfolioViewController: UIViewController {
    private let stocksFetcherService = StocksFetcherService()
    private let localStorage: LocalStorageProtocol = LocalStorage()
    
    private var stocks: [PortfolioStockModel] {
        return localStorage.objects().reversed()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .material
        tableView.registerReusableCell(StockPortfolioTableViewCell.self)
        tableView.isHidden = true
        
        return tableView
    }()
    
    private lazy var placeholderView: SearchPlaceholderView = {
        let viewModel = SearchPlaceholderViewModel(image: Localization.Stocks.stocksPlaceHolderImage.rawValue,
                                                   title: Localization.Stocks.stocksPlaceHolderTitle.rawValue)
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
        if stocks.count > 0 {
            tableView.isHidden = false
            placeholderView.isHidden = true
            updatePortfolio()
        } else {
            tableView.isHidden = true
            placeholderView.isHidden = false
        }
    }
    
    private func updatePortfolio() {
        stocksFetcherService.portfolioStock(savedStocks: stocks) { [weak self] in
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
        let searchStocksVC = StocksSearchViewController()
        navigationController?.pushViewController(searchStocksVC, animated: true)
    }
}

extension StocksPortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as StockPortfolioTableViewCell
        cell.configureCell(with: stocks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stock = stocks[indexPath.row]
        let viewController = StockHistoryViewController(ticker: stock.ticker)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let stock = stocks[indexPath.row]
        let ticker = stock.ticker
        
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, _) in
            guard let model: PortfolioStockModel = self.localStorage.object(ticker) else { return }
            
            model.historyPurchaseStocks.forEach { self.localStorage.delete($0)}
            self.localStorage.delete(model)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateViewState()
        }
        
        let edit = UIContextualAction(style: .normal, title: "Изменить") { (_, _, _) in
            guard let model: PortfolioStockModel = self.localStorage.object(ticker) else { return }
            
            let alert = UIAlertController(title: "Редактирование", message: "Уменьшите количество активов", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = "\(stock.lots)"
                textField.keyboardType = .numberPad
            }
            
            let cancel = UIAlertAction(title: "Отменить", style: .cancel)
            let edit = UIAlertAction(title: "Изменить", style: .default) { _ in
                guard let text = alert.textFields?[0].text,
                      !text.isEmpty, let lots = Int(text),
                      lots < stock.lots,
                      lots > 0 else { return }
                self.localStorage.update {
                    let history = PurchaseStock(historyType: .remove, purchasePrice: 0, lots: model.lots - lots, date: Date().toString())
                    model.lots = lots
                    model.historyPurchaseStocks.append(history)
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


//
//  StockHistoryViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 20.03.2022.
//

import UIKit

class StockHistoryViewController: UIViewController {
    private let localStorage: LocalStorageProtocol = LocalStorage()
    private let ticker: String
    private lazy var stock: PortfolioStockModel? = localStorage.object(ticker)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .material
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerReusableCell(StockHistoryTableViewCell.self)
        
        return tableView
    }()
    
    init(ticker: String) {
        self.ticker = ticker
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .material
        view.addSubview(tableView)
        navigationItem.title = stock?.companyName
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension StockHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stock?.historyPurchaseStocks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as StockHistoryTableViewCell
        guard let historyStock = stock?.historyPurchaseStocks.reversed()[indexPath.row] else { return UITableViewCell() }
        
        cell.configureCell(with: historyStock)
        return cell
    }
}

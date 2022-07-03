//
//  CryptoHistoryViewController.swift
//  Track Finance
//
//  Created by Alina on 12.04.2022.
//

import UIKit

class CryptoHistoryViewController: UIViewController {
    private let localStorage: LocalStorageProtocol = LocalStorage()
    private let symbol: String
    private lazy var crypto: PortfolioCryptoModel? = localStorage.object(symbol)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .material
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerReusableCell(CryptoHistoryTableViewCell.self)
        
        return tableView
    }()
    
    init(symbol: String) {
        self.symbol = symbol
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .material
        view.addSubview(tableView)
        navigationItem.title = crypto?.name
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CryptoHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crypto?.historyPurchaseCrypto.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CryptoHistoryTableViewCell
        guard let historyCrypto = crypto?.historyPurchaseCrypto.reversed()[indexPath.row] else { return UITableViewCell() }
        
        cell.configureCell(with: historyCrypto)
        return cell
    }
}

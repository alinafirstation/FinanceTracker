//
//  StockDetailsViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 27.02.2022.
//

import UIKit

class StockDetailsViewController: UIViewController {
    private let stock: Stock
    private let localStorage: LocalStorageProtocol = LocalStorage()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .material
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerReusableCell(DetailsPriceTableViewCell.self)
        tableView.registerReusableCell(StockDetailsParametersTableViewCell.self)
        
        return tableView
    }()
    
    init(stock: Stock) {
        self.stock = stock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupView()
        setupConstraints()
        
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

    
    private func setupView() {
        view.backgroundColor = .white
        title = stock.companyName
        view.addSubview(tableView)
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem(title: "", image: nil, primaryAction: nil, menu: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc dynamic func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + tableView.rowHeight, right: 0)
            let indexPath = IndexPath(row: DetailsCellType.parameters.rawValue, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }

    @objc dynamic func keyboardWillHide() {
        UIView.animate(withDuration: 0.2) {
            self.tableView.contentInset = .zero
        }
    }
}

extension StockDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DetailsCellType.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = DetailsCellType.getRow(indexPath.row)
        
        switch row {
        case .price:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as DetailsPriceTableViewCell
            cell.configureCell(with: stock)
            return cell
        case .parameters:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as StockDetailsParametersTableViewCell
            cell.actionDelegate = self
            cell.setupViewModel()
            return cell
        }
    }
}

extension StockDetailsViewController: ParametersViewDelegate {
    func addButtonDidTapped(with purchasePrice: Double, lots: Int, date: String) {
        let portfolioStockModel = PortfolioStockModel(ticker: stock.ticker,
                                                      companyName: stock.companyName,
                                                      moneyAmount: purchasePrice,
                                                      lots: lots)
        let date = Date()
        let purchaseStock = PurchaseStock(historyType: .add, purchasePrice: purchasePrice, lots: lots, date: date.toString())
        let stock: PortfolioStockModel? = localStorage.object(stock.ticker)
        
        guard let stock = stock else {
            portfolioStockModel.historyPurchaseStocks.append(purchaseStock)
            localStorage.write(portfolioStockModel)
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        localStorage.update {
            stock.lots += lots
            stock.moneyAmount += purchasePrice
            stock.historyPurchaseStocks.append(purchaseStock)
        }

        navigationController?.popToRootViewController(animated: true)
    }
    
    func showAlert() {
        present(title: "Некорректные данные", message: "Проверьте правильность заполнения ваших полей")
    }
}


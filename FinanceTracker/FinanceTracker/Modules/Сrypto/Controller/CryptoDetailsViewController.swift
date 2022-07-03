//
//  CryptoDetailsViewController.swift
//  Track Finance
//
//  Created by Alina on 08.04.2022.
//

import UIKit

class CryptoDetailsViewController: UIViewController {
    private let crypto: Crypto
    private let localStorage: LocalStorageProtocol = LocalStorage()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .material
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerReusableCell(DetailsPriceTableViewCell.self)
        tableView.registerReusableCell(CryptoDetailsParametersTableViewCell.self)
        
        return tableView
    }()
    
    init(crypto: Crypto) {
        self.crypto = crypto
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
        title = crypto.name
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

extension CryptoDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DetailsCellType.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = DetailsCellType.getRow(indexPath.row)
        
        switch row {
        case .price:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as DetailsPriceTableViewCell
            cell.configureCell(with: crypto)
            return cell
        case .parameters:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CryptoDetailsParametersTableViewCell
            cell.actionDelegate = self
            cell.setupViewModel()
            return cell
        }
    }
}

extension CryptoDetailsViewController: ParametersViewDelegate {
    func addButtonDidTapped(with purchasePrice: Double, amount: Double, date: String) {
        let portfolioCryptoModel = PortfolioCryptoModel(name: crypto.name,
                                                        tether: crypto.tether,
                                                        moneyAmount: purchasePrice,
                                                        currentPrice: crypto.price,
                                                        amount: amount)
  
        let date = Date()
        let purchaseCrypto = PurchaseCrypto(historyType: .add, purchasePrice: purchasePrice, amount: amount, date: date.toString())
        let crypto: PortfolioCryptoModel? = localStorage.object(crypto.tether)
        
        guard let crypto = crypto else {
            portfolioCryptoModel.historyPurchaseCrypto.append(purchaseCrypto)
            localStorage.write(portfolioCryptoModel)
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        localStorage.update {
            crypto.amount += amount
            crypto.moneyAmount += purchasePrice
            crypto.historyPurchaseCrypto.append(purchaseCrypto)
        }

        navigationController?.popToRootViewController(animated: true)
    }
    
    func showAlert() {
        present(title: "Некорректные данные", message: "Проверьте правильность заполнения ваших полей")
    }
}

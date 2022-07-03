//
//  CryptoSearchViewController.swift
//  Track Finance
//
//  Created by Alina on 06.04.2022.
//

import UIKit
import SnapKit

class CryptoSearchViewController: UIViewController {
    private let cryptoFetcherService = CryptoFetcherService()
    private var cryptos: [Crypto]?
    private var filteredCrypto = [Crypto]()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localization.Crypto.cryptoSearchBarPlaceholder.rawValue
        
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .material
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusableCell(CryptoSearchTableViewCell.self)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        cryptoFetcherService.getCrypto { cryptos in
            self.cryptos = cryptos.sorted(by: { $0.price ?? 0  > $1.price ?? 0 })
            self.tableView.reloadData()
        }
    }
    
    private func setupView() {
        view.addSubview(tableView)
        setupNavBar()
        definesPresentationContext = true
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem(title: "", image: nil, primaryAction: nil, menu: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.title = Localization.Crypto.cryptoTitle.rawValue
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func fetchCorrectCrypto(withIndex index: Int) -> Crypto? {
        guard let cryptos = cryptos else { return nil }
        var crypto: Crypto

        if filteredCrypto.count > index, isFiltering {
            crypto = filteredCrypto[index]
            return crypto
        } else if cryptos.count > index {
            crypto = cryptos[index]
            return crypto
        }

        return nil
    }
    
}

extension CryptoSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCrypto.count
        }
        
        return cryptos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CryptoSearchTableViewCell
        
        guard let crypto = fetchCorrectCrypto(withIndex: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(withModel: crypto)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let crypto = fetchCorrectCrypto(withIndex: indexPath.row) else { return }
        
        let cryptoDetailsViewController = CryptoDetailsViewController(crypto: crypto)
        navigationController?.pushViewController(cryptoDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CryptoSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        guard let cryptos = cryptos else { return }

        filteredCrypto = cryptos.filter { crypto in
            crypto.name.lowercased().contains(searchText.lowercased())
        }

        tableView.reloadData()
    }
}


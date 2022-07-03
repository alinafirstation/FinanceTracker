//
//  StocksSearchViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 30.01.2022.
//

import UIKit

class StocksSearchViewController: UIViewController {
    private let stocksFetcherService = StocksFetcherService()
    private var stocks: [Stock]?
    private var filteredStocks = [Stock]()
    
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
        searchController.searchBar.placeholder = Localization.Stocks.stocksSearchBarPlaceholder.rawValue
        
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .material
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusableCell(SearchStocksTableViewCell.self)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        stocksFetcherService.getStock { stocks in
            self.stocks = stocks.sorted { $0.companyName < $1.companyName }
            self.tableView.reloadData()
        }
    }
    
    private func setupView() {
        view.addSubview(tableView)
        setupNavBar()
        definesPresentationContext = true
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem(title: "", image: nil, primaryAction: nil, menu: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.title = Localization.Stocks.stocksTitle.rawValue
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func fetchCorrectStock(withIndex index: Int) -> Stock? {
        guard let stocks = stocks else { return nil }
        var stock: Stock
        
        if filteredStocks.count > index, isFiltering {
            stock = filteredStocks[index]
            return stock
        } else if stocks.count > index {
            stock = stocks[index]
            return stock
        }
        
        return nil
    }
}

extension StocksSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredStocks.count
        }
        
        return stocks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SearchStocksTableViewCell
        
        guard let stock = fetchCorrectStock(withIndex: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(withModel: stock)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stock = fetchCorrectStock(withIndex: indexPath.row) else { return }
        
        let stockDetailsViewController = StockDetailsViewController(stock: stock)
        navigationController?.pushViewController(stockDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension StocksSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        guard let stocks = stocks else { return }
        
        filteredStocks = stocks.filter { stock in
            stock.companyName.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}

//
//  StatisticsViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.03.2022.
//

import UIKit
import SnapKit

class StatisticsViewController: UIViewController {
    private let factory = StatisticsDataSourceFactory()
    private var dataSource: [StatisticsDataSourceContainer] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .material
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var placeholderView: SearchPlaceholderView = {
        let viewModel = SearchPlaceholderViewModel(image: Localization.Statistics.statisticsPlaceHolderImage.rawValue,
                                                   title: Localization.Statistics.statisticsPlaceHolderTitle.rawValue)
        let view = SearchPlaceholderView(viewModel: viewModel)
        view.isHidden = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        updateDataSource()
    }
    
    private func setupView() {
        view.backgroundColor = .material
        view.addSubview(tableView)
        view.addSubview(placeholderView)

        navigationController?.setupNavigationController()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        placeholderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func updateDataSource() {
        dataSource = factory.createStatistics()
    }
}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.row]

        switch cellType {
        case .chart(let viewModel):
            return tableView.dequeueReusableCellWithViewModel(viewModel: viewModel)
        case .statisticsInfo(let viewModel):
            return tableView.dequeueReusableCellWithViewModel(viewModel: viewModel)
        }
    }
}

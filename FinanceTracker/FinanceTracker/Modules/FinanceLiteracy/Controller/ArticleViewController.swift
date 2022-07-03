//
//  ArticleViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.03.2022.
//

import UIKit
import SnapKit

class ArticleViewController: UIViewController {
    private let article: [Article]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .material
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerReusableCell(ArticleImageTableViewCell.self)
        tableView.registerReusableCell(ArticleTitleTableViewCell.self)
        tableView.registerReusableCell(ArticleTextTableViewCell.self)
        
        return tableView
    }()
    
    init(model: ArticleBlock) {
        self.article = model.article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavBar()
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem(title: Localization.Common.back.rawValue, image: nil, primaryAction: nil, menu: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupView() {
        view.backgroundColor = .material
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ArticleCellType.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = article[indexPath.row]
        let articleType = ArticleCellType(rawValue: article.type)
        
        switch articleType {
        case .image:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ArticleImageTableViewCell
            cell.configureCell(image: article.content)
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ArticleTitleTableViewCell
            cell.configureCell(title: article.content)
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ArticleTextTableViewCell
            cell.configureCell(text: article.content)
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
}

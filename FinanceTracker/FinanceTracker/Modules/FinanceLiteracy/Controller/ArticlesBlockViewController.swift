//
//  ArticlesBlockViewController.swift
//  Track Finance
//
//  Created by Alina on 28.03.2022.
//

import UIKit

class ArticlesBlockViewController: UIViewController {
    private let articlesFetcherService = ArticlesFetcherService()
    private var articles = [ArticleBlock]()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.minimumInteritemSpacing = Constants.cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .material
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: Constants.contentInsetValue,
                                                   left: Constants.contentInsetValue,
                                                   bottom: Constants.contentInsetValue,
                                                   right: Constants.contentInsetValue)
        
        return collectionView
    }()
    
    init(model: EducationPreview) {
        super.init(nibName: nil, bundle: nil)
        self.articles = model.articles
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .material
        view.addSubview(collectionView)
        navigationController?.setupNavigationController()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ArticlesBlockViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.identifier, for: indexPath) as? ArticleCollectionViewCell else { return UICollectionViewCell() }
        let article = articles[indexPath.row]
        cell.configureCell(model: article)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let articleViewController = ArticleViewController(model: article)
        navigationController?.pushViewController(articleViewController, animated: true)
    }
}

extension ArticlesBlockViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width / Constants.itemsPerRow - Constants.cellSpacing / 2 - Constants.contentInsetValue
        
        return CGSize(width: widthPerItem, height: Constants.cellHeight)
    }
}

extension ArticlesBlockViewController {
    private struct Constants {
        static let cellSpacing: CGFloat = 10
        static let itemsPerRow: CGFloat = 2
        static let cellHeight: CGFloat = 150
        static let contentInsetValue: CGFloat = 10
    }
}

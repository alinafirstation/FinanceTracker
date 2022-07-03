//
//  EducationViewController.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.03.2022.
//

import UIKit

class EducationViewController: UIViewController {
    private let articlesFetcherService = ArticlesFetcherService()
    private var blocks = [EducationPreview]()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        articlesFetcherService.fetchBlocks { blocks in
            guard let blocks = blocks else { return }
            self.blocks = blocks
            self.collectionView.reloadData()
        }
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

extension EducationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.identifier, for: indexPath) as? ArticleCollectionViewCell else { return UICollectionViewCell() }
        let block = blocks[indexPath.row]
        cell.configureCell(model: block)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let block = blocks[indexPath.row]
        let articlesViewController = ArticlesBlockViewController(model: block)
        navigationController?.pushViewController(articlesViewController, animated: true)
    }
}

extension EducationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width - Constants.cellSpacing / 2 - Constants.contentInsetValue
        
        return CGSize(width: widthPerItem, height: Constants.cellHeight)
    }
}

extension EducationViewController {
    private struct Constants {
        static let cellSpacing: CGFloat = 10
        static let cellHeight: CGFloat = 150
        static let contentInsetValue: CGFloat = 10
    }
}

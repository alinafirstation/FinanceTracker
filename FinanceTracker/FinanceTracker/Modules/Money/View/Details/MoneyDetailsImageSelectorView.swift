//
//  MoneyDetailsImageSelectorView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.04.2022.
//

import UIKit

struct MoneyDetailsImageSelectorViewModel {
    let imageViewModels: [ReusableCollectionContainerCellViewModel<ImageView>]
    weak var delegate: MoneyDetailsImageSelectorViewDelegate?
}

protocol MoneyDetailsImageSelectorViewDelegate: AnyObject {
    func didSelectImage(atIndex index: Int)
}

class MoneyDetailsImageSelectorView: UIView {
    weak var delegate: MoneyDetailsImageSelectorViewDelegate?
    private var dataSource: [ReusableCollectionContainerCellViewModel<ImageView>] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 16,
                                                   bottom: 0,
                                                   right: 0)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.cellHeight).priority(.high)
        }
    }
    
    private func updateView(withDataSource dataSource: [ReusableCollectionContainerCellViewModel<ImageView>]) {
        self.dataSource = dataSource
        collectionView.reloadData()
    }
}

extension MoneyDetailsImageSelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCellWithViewModel(viewModel: dataSource[indexPath.row], indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectImage(atIndex: indexPath.row)
    }
}

extension MoneyDetailsImageSelectorView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
    }
}

extension MoneyDetailsImageSelectorView: ViewModelSettable {
    func setup(with viewModel: MoneyDetailsImageSelectorViewModel) {
        updateView(withDataSource: viewModel.imageViewModels)
        delegate = viewModel.delegate
    }
}

extension MoneyDetailsImageSelectorView {
    private struct Constants {
        static let cellHeight: CGFloat = 70
        static let cellWidth: CGFloat = 70
    }
}

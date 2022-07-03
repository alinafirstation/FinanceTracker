//
//  ImageView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 24.04.2022.
//

import UIKit

struct ImageViewModel {
    let imageName: String
    let isActive: Bool
}

class ImageView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ImageView: ViewModelSettable {
    func setup(with viewModel: ImageViewModel) {
        imageView.image = UIImage(named: "\(viewModel.imageName)")
        
        if viewModel.isActive {
            imageView.layer.borderColor = UIColor.green.cgColor
            imageView.layer.borderWidth = 3
        } else {
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 1
        }
    }
}

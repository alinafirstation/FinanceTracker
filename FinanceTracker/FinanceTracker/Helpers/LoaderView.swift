//
//  LoaderView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 20.03.2022.
//

import UIKit

class LoaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)

        addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let indicator = UIActivityIndicatorView()
        
        if #available(iOS 13.0, *) {
            indicator.style = .medium
        }
        
        indicator.startAnimating()
        indicator.color = .white
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

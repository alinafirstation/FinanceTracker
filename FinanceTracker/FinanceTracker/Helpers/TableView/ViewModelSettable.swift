//
//  ViewModelSettable.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 23.04.2022.
//

import UIKit

protocol ViewModelSettable: AnyObject {
    associatedtype ViewModel
    func setup(with viewModel: ViewModel)
    func prepareForReuse()
}

extension ViewModelSettable {
    func prepareForReuse() {}
}

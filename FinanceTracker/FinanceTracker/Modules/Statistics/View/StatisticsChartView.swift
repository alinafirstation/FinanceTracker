//
//  StatisticsChartView.swift
//  Track Finance
//
//  Created by Alina Cherepanova on 08.05.2022.
//

import UIKit
import Charts

struct StatisticsChartViewModel {

}

class StatisticsChartView: UIView {
    private let chartView = PieChartView()

    private var stocksDataEntry = PieChartDataEntry(value: 0)
    private var cryptoDataEntry = PieChartDataEntry(value: 0)
    private var moneyDataEntry = PieChartDataEntry(value: 0)

    private var numberOfDownloadDataEntries = [PieChartDataEntry]()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(chartView)
        setupConstraints()
    }

    private func setupConstraints() {
        chartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(300)
        }
    }
}

extension StatisticsChartView: ViewModelSettable {
    func setup(with viewModel: StatisticsChartViewModel) {
        stocksDataEntry.value = 5548
        cryptoDataEntry.value = 12399
        moneyDataEntry.value = 10287

        stocksDataEntry.label = "Акции"
        cryptoDataEntry.label = "Криптовалюта"
        moneyDataEntry.label = "Деньги"

        numberOfDownloadDataEntries = [stocksDataEntry, cryptoDataEntry, moneyDataEntry]

        let chartDataSet = PieChartDataSet(entries: numberOfDownloadDataEntries, label: "")
        let charData = PieChartData(dataSet: chartDataSet)
        let color = [UIColor.stockChart, UIColor.cryptoChart, UIColor.moneyChart]
        chartDataSet.colors = color as [NSUIColor]
        chartDataSet.entryLabelColor = .white
        chartDataSet.entryLabelFont = AppFont.font(type: .SemiBold, size: 16)
        chartDataSet.valueTextColor = .white
        chartDataSet.valueFont = AppFont.font(type: .SemiBold, size: 16)
        chartDataSet.highlightEnabled = false
        chartView.holeColor = .clear
        chartView.legend.enabled = false

        chartView.data = charData
    }
}

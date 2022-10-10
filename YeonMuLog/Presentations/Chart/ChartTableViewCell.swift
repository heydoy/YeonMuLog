//
//  ChartTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/04.
//

import UIKit
import Charts

class ChartTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .bigTitle, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    lazy var barChartView = BarChartView().then {
        $0.data = nil
        $0.xAxis.labelPosition = .bottom
        $0.rightAxis.enabled = false
        $0.animate(xAxisDuration: 0.6, yAxisDuration: 0.4)
        $0.isUserInteractionEnabled = false
    }
    
    let dividerView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    // MARK: - Inintialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
        setUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(barChartView)
        contentView.addSubview(dividerView)
    }
    
    func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        barChartView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.height.equalTo(300)
        }
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(barChartView.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(8)
        }
        
    }
    
    func setData(data: BarChartDataSet, title: String) {
        

        // 타이틀
        titleLabel.text = title

        // 파이 차트 설정
        let chartDataSet = data

        // 차트 컬러
        chartDataSet.colors = [UIColor.CustomColor.purple100, UIColor.CustomColor.purple200, UIColor.CustomColor.purple500 ]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
    }
    
    func setUI() {
        
    }

}

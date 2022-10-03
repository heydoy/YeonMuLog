//
//  ChartViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import UIKit
import RealmSwift
import Charts

class ChartViewController: BaseViewController {

    // MARK: - Properties
    let mainView = ChartView()
    let repository = UserPlayRepository.shared
    var list: Results<UserPlayInfo>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if repository.fetch() != list {
            list = repository.fetch()
       }
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    override func setNavigationBar() {
        navigationItem.title = "통계"
    }
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(NoChartTableViewCell.self, forCellReuseIdentifier: String(describing: NoChartTableViewCell.self))
        mainView.tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: String(describing: ChartTableViewCell.self))
    }
    
}
// MARK: - Table View
extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list != nil && !list.isEmpty ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if list != nil && !list.isEmpty {
            if indexPath.row == 0 {
                // 가장 리뷰를 많이 남긴 극
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChartTableViewCell.self)) as? ChartTableViewCell else { return UITableViewCell() }
                
                let dataSet = reviewBarChartDataSet()
                let data = dataSet.0
                let title = dataSet.1
                let play = dataSet.2
                cell.setData(data: data, title: title)
                cell.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: play)
                cell.barChartView.xAxis.setLabelCount(play.count, force: false)
                return cell
            } else if indexPath.row == 1 {
                // 가장 관극을 많이한 요일
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChartTableViewCell.self)) as? ChartTableViewCell else { return UITableViewCell() }
                
                let dataSet = dateBarChartDataSet()
                let data = dataSet.0
                let title = dataSet.1
                let day = dataSet.2
                cell.setData(data: data, title: title)
                cell.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: day)
                cell.barChartView.xAxis.setLabelCount(day.count, force: false)
                return cell
            } else {
                return UITableViewCell()
            }
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoChartTableViewCell.self)) as? NoChartTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}

// 차트 데이터 설정
extension ChartViewController {
    func reviewBarChartDataSet() -> (BarChartDataSet, String, [String]) {
        var play: [String] = []
        var reviewNumber: [Double] = []
        
        if let list = list {
            list.forEach {
                play.append($0.title)
                reviewNumber.append(Double($0.userReview.count))
            }
        }
        
        var dataEntries: [BarChartDataEntry] = []
        
        for index in 0..<play.count {
            let dataEntry = BarChartDataEntry(x: Double(index), y: reviewNumber[index])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "리뷰 수")
        let title = "✍️ 리뷰를 제일 많이 쓴 극은\n\(play[reviewNumber.firstIndex(of: reviewNumber.max()!)!])으로\n총 \(Int(reviewNumber.max()!))개의 리뷰를 썼습니다."
        return (chartDataSet, title, play)
    }
    
    func dateBarChartDataSet() -> (BarChartDataSet, String, [String]) {
        let date: [String] = ["월","화","수","목","금","토"]
        var watched: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        if let list = list {
            list.forEach {
                for index in 0..<date.count {
                    if $0.date.extractDate() == date[index] {
                        watched[index] += 1.0
                    }
                }
            }
        }
       
        var dataEntries: [BarChartDataEntry] = []
        
        for index in 0..<date.count {
            let dataEntry = BarChartDataEntry(x: Double(index), y: watched[index])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "요일")
        let title = "📆 극을 제일 많이 본 요일은\n\(date[watched.firstIndex(of: watched.max()!)!])요일로\n총 \(Int(watched.max()!))번 관극하였습니다."
        return (chartDataSet, title, date)
    }
}

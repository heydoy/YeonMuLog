//
//  ChartView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import UIKit

class ChartView: BaseView {
    lazy var tableView = UITableView().then {
        $0.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        $0.separatorColor = .clear
        $0.sectionHeaderTopPadding = .zero
    }

    override func setupUI() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

//
//  SettingView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/04.
//

import UIKit

class SettingView: BaseView {
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        $0.separatorColor = .clear
        
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

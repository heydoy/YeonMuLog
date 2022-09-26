//
//  TaraeDetailView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/25.
//

import UIKit
import Then
import SnapKit

class TaraeDetailView: BaseView {
    lazy var tableView = UITableView().then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.separatorColor = .clear
        $0.backgroundColor = UIColor(red: 181/255, green: 124/255, blue: 255/255, alpha: 1)
    }
    
    let addReviewButton = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.backgroundColor = UIColor(red: 181/255, green: 124/255, blue: 255/255, alpha: 1)
        $0.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        $0.tintColor = .white
    }

    override func setupUI() {
        self.addSubview(tableView)
        self.addSubview(addReviewButton)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addReviewButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }

}

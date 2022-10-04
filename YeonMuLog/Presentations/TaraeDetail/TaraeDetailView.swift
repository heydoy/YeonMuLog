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
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorColor = .clear
        $0.backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 243/255, alpha: 1)
        $0.bounces = false        
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
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        addReviewButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }

}

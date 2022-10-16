//
//  SearchPlayView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import UIKit
import Then
import SnapKit
import Lottie

class SearchPlayView: BaseView {
    
    lazy var lottieView = AnimationView(name: "yeonmulog-loading-animation").then {
        $0.contentMode = .scaleAspectFill
        $0.loopMode = .loop
        $0.animationSpeed = 1.0
    }
    
    let dimmedView = UIImageView().then {
        $0.image = UIImage(named: "dimmed-bg")
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    
    lazy var tableView = UITableView().then {
        $0.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        $0.separatorColor = .clear
        $0.rowHeight = UITableView.automaticDimension
    }

    override func setupUI() {
        self.addSubview(tableView)
        self.addSubview(dimmedView)
        dimmedView.addSubview(lottieView)
    }
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lottieView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.66)
            make.width.equalTo(250)
            make.height.equalTo(150)
        }

    }
}

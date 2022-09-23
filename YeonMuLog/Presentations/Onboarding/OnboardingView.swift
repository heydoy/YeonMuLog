//
//  OnboardingView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

class OnboardingView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = true

    }
    
    let pageControl = UIPageControl().then {
        $0.tintColor = UIColor(red: 181/255, green: 124/255, blue: 255/255, alpha: 1)
        $0.numberOfPages = 3
        $0.currentPage = 1
    }
    
    let goMainButton = UIButton().then {
        $0.setTitle("goMainButtonTitle".localized, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = .appleSDGothicNeo(of: .subTitle, weight: .bold)
        $0.tintColor = .white
        $0.backgroundColor = UIColor(red: 181/255, green: 124/255, blue: 255/255, alpha: 1)
        
    }

    override func setupUI() {
        self.addSubview(collectionView)
        self.addSubview(goMainButton)
        self.addSubview(pageControl)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.67)
        }
        
        goMainButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(goMainButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
            make.topMargin.greaterThanOrEqualTo(collectionView.snp.bottom).offset(12)
        }
    }

}

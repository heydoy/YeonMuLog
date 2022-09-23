//
//  OnboardingView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import Then
import SnapKit

class OnboardingView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = true

    }
    
    let pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = .systemGray4
        $0.currentPageIndicatorTintColor = UIColor(red: 181/255, green: 124/255, blue: 255/255, alpha: 1)
        $0.numberOfPages = 3
        $0.currentPage = 0
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
            make.top.greaterThanOrEqualToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.67)
            make.bottom.equalTo(pageControl.snp.top).offset(-24)
        }
        
        goMainButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(goMainButton.snp.top).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
            make.topMargin.greaterThanOrEqualTo(collectionView.snp.bottom).offset(12)
        }
    }

}

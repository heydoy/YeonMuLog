//
//  NoReviewCollectionViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import UIKit

class NoReviewCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private let guideLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .regular)
        $0.textColor = .CustomColor.purple500
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "NoUserReview".localized
    }
    
    private let characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "character-surprised")
    }
    
    // MARK: - Initialise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        configure()
        setConstraints()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    private func configure() {
        contentView.addSubview(guideLabel)
        contentView.addSubview(characterImageView)
    }
    
    
    private func setConstraints() {
        guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalTo(guideLabel)
            make.top.equalTo(guideLabel.snp.bottom).offset(4)
            make.width.height.equalTo(80)
            make.bottom.greaterThanOrEqualToSuperview().inset(20)
            
        }
    }
    private func setUI() {
        backgroundColor = .clear
    }
}

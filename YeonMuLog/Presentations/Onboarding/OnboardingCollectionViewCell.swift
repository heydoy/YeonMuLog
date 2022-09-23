//
//  OnboardingCollectionViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .title, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    let subtitleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = .systemGray
        $0.numberOfLines = 0
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
    
    func setData(_ message: OnboardingMessage) {
        mainImageView.image = UIImage(named: message.imageName)
        titleLabel.text = message.title
        subtitleLabel.text = message.subtitle
    }

    // MARK: - UI
    private func configure() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }

    private func setConstraints() {
        
        mainImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(mainImageView.snp.width).multipliedBy(1.11)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setUI() {
        backgroundColor = .clear
    }
}

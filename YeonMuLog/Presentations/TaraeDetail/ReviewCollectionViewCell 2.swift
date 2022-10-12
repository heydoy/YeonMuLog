//
//  ReviewCollectionViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let dateLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .content, weight: .regular)
        $0.textColor = .darkGray
        $0.textAlignment = .left
    }
    
    let textLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let bubbleBackgroundView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
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
    
    func setData(review: UserReview) {
        textLabel.text = review.text
        dateLabel.text = review.date.reviewDateString()
    }
    
    // MARK: - UI
    private func configure() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(bubbleBackgroundView)
        bubbleBackgroundView.addSubview(textLabel)
    }

    private func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        textLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(contentView).multipliedBy(0.6)
            make.top.bottom.equalToSuperview().inset(12)
        }
        bubbleBackgroundView.snp.makeConstraints { make in
            make.width.height.equalTo(textLabel).offset(20)
            make.top.equalTo(dateLabel).offset(-6)
            make.leading.equalTo(dateLabel.snp.trailing).offset(8)
            make.bottom.greaterThanOrEqualToSuperview()
        }

    }
    private func setUI() {
        backgroundColor = .clear
    }
    
}

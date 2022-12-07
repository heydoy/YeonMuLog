//
//  TaraeDetailReviewTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import UIKit

final class TaraeDetailReviewTableViewCell: UITableViewCell {
    // MARK: - Properties
    let dateLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .content, weight: .regular)
        $0.textColor = .darkGray
        $0.textAlignment = .left
    }
    let chatLabel = UILabel().then {
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
    // MARK: - Inintialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
        setUI()
        selectionStyle = .none
    }
    func setData(review: UserReview) {
        chatLabel.text = review.text
        dateLabel.text = review.date.reviewDateString()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func configure() {
        contentView.addSubview(bubbleBackgroundView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(chatLabel)
    }
    
    func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.equalToSuperview().inset(12)
            make.width.equalTo(80)
        }
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel).offset(4)
            make.leading.equalTo(dateLabel.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(72)
            make.bottom.equalToSuperview()
        }
        bubbleBackgroundView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(chatLabel).offset(8)
            make.top.leading.equalTo(chatLabel).offset(-8)
        }
    }
    func setUI() {
        backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 243/255, alpha: 1)
    }
}

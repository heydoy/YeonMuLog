//
//  TaraeReviewTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import RealmSwift

final class TaraeReviewTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let cellBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = .zero
        $0.layer.shadowOpacity = 0.1
    }
    
    private let posterImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .title, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
        
    }
    
    private let reviewBackgroundView = UIView().then {
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray6
    }
    
    private let reviewIconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "quote.bubble")
        $0.tintColor = .purple
        $0.preferredSymbolConfiguration = .init(pointSize: 11)
        $0.contentMode = .scaleAspectFit
        
    }
    private let reviewLabel = UILabel().then {
        $0.textColor = .purple
        $0.font = .appleSDGothicNeo(of: .content, weight: .medium)
        $0.text = "리뷰 0"
    }
    
    private let castIconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.2.fill")
        $0.preferredSymbolConfiguration = .init(pointSize: 10)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    private let placeIconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "location.circle.fill")
        $0.preferredSymbolConfiguration = .init(pointSize: 11)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    private let castLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.numberOfLines = 0
    }
    private let placeLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.numberOfLines = 0
    }
    private let dateLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.numberOfLines = 0
        $0.textColor = .systemGray
    }
    

    

    // MARK: - Inintialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
        setUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: UserPlayInfo) {
        titleLabel.text = data.title
        let url = URL(string: data.poster)
        posterImageView.kf.setImage(with: url)
        dateLabel.text = "\(data.date) (\(data.runtime))"
        castLabel.text = data.casts.joined(separator: ", ")
        placeLabel.text = data.place
        reviewLabel.text = "리뷰 \(data.userReview.count)"
    }
    
    // MARK: - UI
    private func configure() {
        self.contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(posterImageView)
        cellBackgroundView.addSubview(titleLabel)
        cellBackgroundView.addSubview(dateLabel)
        cellBackgroundView.addSubview(castLabel)
        cellBackgroundView.addSubview(placeLabel)
        cellBackgroundView.addSubview(castIconImageView)
        cellBackgroundView.addSubview(placeIconImageView)
        
        cellBackgroundView.addSubview(reviewBackgroundView)
        reviewBackgroundView.addSubview(reviewIconImageView)
        reviewBackgroundView.addSubview(reviewLabel)
    }
    
    private func setConstraints() {
        cellBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview().inset(4)
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(150)
        }
        posterImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.28)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.3)
            make.centerY.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview().offset(-10)
            make.top.leading.equalToSuperview().offset(10)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(10)
            make.height.greaterThanOrEqualTo(30)
        }
        
        reviewBackgroundView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(64)
            
        }
        
        reviewIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(6)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(6)
            make.centerY.equalToSuperview()
            make.leading.equalTo(reviewIconImageView.snp.trailing).offset(2)
        }

        castIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        castLabel.snp.makeConstraints { make in
            make.trailing.equalTo(reviewBackgroundView)
            make.leading.equalTo(castIconImageView.snp.trailing).offset(2)
            make.top.equalTo(castIconImageView)
        }
        
        placeIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(titleLabel)
            make.top.equalTo(castLabel.snp.bottom).offset(3)
        }
        placeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(reviewBackgroundView)
            make.leading.equalTo(placeIconImageView.snp.trailing).offset(2)
            make.top.equalTo(placeIconImageView)
            
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func setUI() {
        backgroundColor = .clear
    }
}

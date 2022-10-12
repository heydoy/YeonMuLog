//
//  TaraeDetailPlayInfoTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import UIKit

class TaraeDetailPlayInfoTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let posterImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "blank-poster-image")
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 20
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
    private let reviewCountLabel = UILabel().then {
        $0.textColor = .purple
        $0.font = .appleSDGothicNeo(of: .content, weight: .medium)
        $0.text = "리뷰 0"
    }
    private let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .bigTitle, weight: .bold)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "뮤지컬 이름이 들어가는 곳 " // 뷰 확인용  코드
    }
    private let castLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.numberOfLines = 0
        $0.text = "캐스팅, 캐스팅, 캐스팅"
    }
    private let placeLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.numberOfLines = 0
        $0.text = "뮤지컬공연장소(공연홀)"
    }
    private let dateLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.numberOfLines = 0
        $0.text = "2022.03.04 20:00 (190분)"
    }
    private let seatAndTicketLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.numberOfLines = 0
        $0.text = "S22 | 66,000원"
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
    private let dateIconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "calendar")
        $0.preferredSymbolConfiguration = .init(pointSize: 11)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    private let seatAndTicketImageView = UIImageView().then {
        $0.image = UIImage(systemName: "ticket.fill")
        $0.preferredSymbolConfiguration = .init(pointSize: 11)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
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
        dateLabel.text = "\(data.date.playString())"
        castLabel.text = data.casts.joined(separator: ", ")
        placeLabel.text = data.place
        seatAndTicketLabel.text = "\(data.seat) | \(data.ticket) 원"
        reviewCountLabel.text = "리뷰 \(data.userReview.count)"
    }
    
    // MARK: - UI
    func configure() {
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(reviewBackgroundView)
        reviewBackgroundView.addSubview(reviewIconImageView)
        reviewBackgroundView.addSubview(reviewCountLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(castLabel)
        self.contentView.addSubview(placeLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(seatAndTicketLabel)
        self.contentView.addSubview(castIconImageView)
        self.contentView.addSubview(placeIconImageView)
        self.contentView.addSubview(dateIconImageView)
        self.contentView.addSubview(seatAndTicketImageView)
    }
    func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.3)
        }
        reviewBackgroundView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(posterImageView).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(64)
            
        }
        reviewIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(6)
        }
        reviewCountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(6)
            make.centerY.equalToSuperview()
            make.leading.equalTo(reviewIconImageView.snp.trailing).offset(2)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(posterImageView.snp.bottom).offset(24)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(40)
        }
        
        castIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(posterImageView)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(castIconImageView)
            make.leading.equalTo(castIconImageView.snp.trailing).offset(4)
        }
        
        placeIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(posterImageView)
            make.top.equalTo(castLabel.snp.bottom).offset(6)
        }
        placeLabel.snp.makeConstraints { make in
            make.top.equalTo(placeIconImageView)
            make.leading.equalTo(placeIconImageView.snp.trailing).offset(4)
        }
        
        dateIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(posterImageView)
            make.top.equalTo(placeLabel.snp.bottom).offset(6)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateIconImageView)
            make.leading.equalTo(dateIconImageView.snp.trailing).offset(4)
        }
        seatAndTicketImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(posterImageView)
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
        }
        seatAndTicketLabel.snp.makeConstraints { make in
            make.top.equalTo(seatAndTicketImageView)
            make.leading.equalTo(seatAndTicketImageView.snp.trailing).offset(4)
            make.bottom.equalToSuperview().inset(36)
        }
        
    }
    func setUI() {
        backgroundColor = .white
    }
}

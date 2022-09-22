//
//  SearchPlayResultTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class SearchPlayResultTableViewCell: UITableViewCell {
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
        $0.layer.cornerRadius = 4
        $0.contentMode = .scaleAspectFill
    }
    private let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .title, weight: .bold)
        $0.textColor = .black
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .content, weight: .medium)
        $0.numberOfLines = 0
    }
    
    private let castLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .content, weight: .medium)
        $0.numberOfLines = 0
    }
    private let placeLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .content, weight: .medium)
        $0.numberOfLines = 0
    }
    
    private let dateIconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "calendar")
        $0.preferredSymbolConfiguration = .init(pointSize: 11)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
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
    
    func setData(data: Play) {
        titleLabel.text = data.title
        let url = URL(string: data.poster)
        posterImageView.kf.setImage(with: url)
        dateLabel.text = "\(data.startDate) ~ \(data.endDate)"
        castLabel.text = data.cast
        placeLabel.text = data.place
    }
    
    // MARK: - UI
    private func configure() {
        self.contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(posterImageView)
        cellBackgroundView.addSubview(titleLabel)
        cellBackgroundView.addSubview(dateLabel)
        cellBackgroundView.addSubview(castLabel)
        cellBackgroundView.addSubview(placeLabel)
        cellBackgroundView.addSubview(dateIconImageView)
        cellBackgroundView.addSubview(castIconImageView)
        cellBackgroundView.addSubview(placeIconImageView)
    }
    
    private func setConstraints() {
        cellBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(4)
            make.height.equalTo(128)
            
        }
        posterImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(12)
            make.trailing.equalTo(posterImageView.snp.leading).offset(-12)
        }
        dateIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel)
            make.leading.equalTo(dateIconImageView.snp.trailing).offset(2)
            make.centerY.equalTo(dateIconImageView)
        }
        
        castIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(dateIconImageView)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
        castLabel.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel)
            make.leading.equalTo(castIconImageView.snp.trailing).offset(2)
            make.top.equalTo(castIconImageView)
        }
        
        placeIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(castIconImageView)
            make.top.equalTo(castLabel.snp.bottom).offset(8)
        }
        placeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel)
            make.leading.equalTo(placeIconImageView.snp.trailing).offset(2)
            make.centerY.equalTo(placeIconImageView)
        }
            
    }
    
    private func setUI() {
        backgroundColor = .clear
    }
    
}

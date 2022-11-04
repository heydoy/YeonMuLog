//
//  WatchedPosterGenreTitleTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import Kingfisher
import Then
import SnapKit

final class WatchedPosterGenreTitleTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let posterImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.image = UIImage(named: "blank-poster-image")
        $0.contentMode = .scaleAspectFill
    }
    
    private let genreLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .content, weight: .medium)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.textColor = .white
        $0.backgroundColor = .CustomColor.musicalTagColor
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .bigTitle, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
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
        let genre = data.genre == "뮤지컬" ? "tagMusical".localized : "tagPlay".localized
        genreLabel.text = "  \(genre)  "
        genreLabel.backgroundColor = data.genre == "뮤지컬" ? .CustomColor.musicalTagColor : .CustomColor.playTagColor
    }
    
    // MARK: - UI
    private func configure() {
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(genreLabel)
        self.contentView.addSubview(titleLabel)
    }
    private func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.72)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.leading.equalTo(genreLabel)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setUI() {
        backgroundColor = .clear
    }

}

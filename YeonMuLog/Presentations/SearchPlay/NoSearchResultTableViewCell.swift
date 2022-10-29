//
//  NoSearchResultTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

class NoSearchResultTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let guideLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .regular)
        $0.textColor = .CustomColor.purple500
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "NoSearchResult".localized
    }
    
    private let characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "character-sweating")
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
    
    func setData(query: String) {
        guideLabel.text = "NoSearchResult".localized(with: query)
    }

    // MARK: - UI
    func configure() {
        self.contentView.addSubview(guideLabel)
        self.contentView.addSubview(characterImageView)
    }
    func setConstraints() {
        guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalTo(guideLabel)
            make.top.equalTo(guideLabel.snp.bottom).offset(4)
            make.width.height.equalTo(108)
            make.bottom.equalToSuperview().inset(20)
            
        }
    }
    func setUI() {
        backgroundColor = .clear
    }

}

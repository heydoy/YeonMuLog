//
//  AddPlayInfoTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import UIKit

final class AddPlayInfoTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let guideLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .caption, weight: .regular)
        $0.textColor = .purple
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = ":)"
    }
    
    private let characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "character-hold-pen")
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

    // MARK: - UI
    func configure() {
        self.contentView.addSubview(guideLabel)
        self.contentView.addSubview(characterImageView)
    }
    func setConstraints() {
        guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(12)
        }
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalTo(guideLabel)
            make.top.equalTo(guideLabel.snp.bottom).offset(4)
            make.width.height.equalTo(80)
            
        }
    }
    func setUI() {
        backgroundColor = .clear
    }
}

//
//  TagCollectionViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import Then
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let tagLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .bold)
        $0.textAlignment = .center
    }
    
    // MARK: - Initialise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        configure()
        setConstraints()
        setUI()
        defaultDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String) {
        tagLabel.text = title
    }
    
    // MARK: - UI
    private func configure() {
        contentView.addSubview(tagLabel)
    }
    func defaultDesign() {
        self.backgroundColor = .systemGray6
        tagLabel.textColor = .black
    }
    
    func pressedDesign() {
        self.backgroundColor = .systemPink
        tagLabel.textColor = .white
    }
    
    private func setConstraints() {
        tagLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(4)
        }
    }
    private func setUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
    }
    
    
    // MARK: - Actions
    func toggleTag(_ tapped: Bool) {
        if tapped {
            pressedDesign()
        } else {
            configure()
        }
    }
}

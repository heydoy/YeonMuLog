//
//  WatchedTagsTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

final class WatchedTagsTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = true
        $0.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TagCollectionViewCell.self))
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
    
    func setData(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - UI
    private func configure() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(collectionView)
    }
    private func setConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func setUI() {
        backgroundColor = .clear
    }
}

//
//  WatchedTextFieldTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import Then
import SnapKit

final class WatchedTextFieldTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    let userTextField = UITextField().then {
        $0.textColor = .darkGray
        $0.font = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.textAlignment = .center
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
    
    func setData(title: String, textFieldText: String, placeHolder: String) {
        titleLabel.text = title
        userTextField.text = textFieldText
        userTextField.placeholder = placeHolder
    }
    
    // MARK: - UI
    private func configure() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(userTextField)
    }
    private func setConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        userTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    private func setUI() {
        backgroundColor = .clear
    }
}

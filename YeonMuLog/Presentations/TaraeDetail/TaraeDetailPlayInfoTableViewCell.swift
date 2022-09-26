//
//  TaraeDetailPlayInfoTableViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import UIKit

class TaraeDetailPlayInfoTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let firstImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    private let reviewTextLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .appleSDGothicNeo(of: .content, weight: .medium)
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
    
    func setData(query: UserReview) {
    
    }
    

    // MARK: - UI
    func configure() {
        self.contentView.addSubview(firstImageView)
    }
    func setConstraints() {

        
    }
    func setUI() {
        backgroundColor = .clear
    }
}

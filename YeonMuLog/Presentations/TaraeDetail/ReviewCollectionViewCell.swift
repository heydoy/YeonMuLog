//
//  ReviewCollectionViewCell.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/26.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    
    // MARK: - Initialise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        configure()
        setConstraints()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String) {
    }
    
    // MARK: - UI
    private func configure() {
        //contentView.addSubview()
    }

    private func setConstraints() {
        
    }
    private func setUI() {
        
    }
    
    
    // MARK: - Actions


}

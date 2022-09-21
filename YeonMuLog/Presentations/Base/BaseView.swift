//
//  BaseView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI() {
        
    }
    
    func setConstraints() {}

}

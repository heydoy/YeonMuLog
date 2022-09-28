//
//  AddReviewView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/28.
//

import UIKit
import Then
import SnapKit

class AddReviewView: BaseView {
    
    let textViewFont: UIFont = UIFont.appleSDGothicNeo(of: .subTitle, weight: .regular)
    
    lazy var textViewMaxHeight: CGFloat = textViewFont.lineHeight * 10
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.autoresizingMask = [.flexibleHeight]
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 4
    }
    
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout() ).then {
        $0.backgroundColor = .clear
    }
    
    lazy var userTextView = UITextView().then {
        $0.font = textViewFont
        $0.textColor = .black
        $0.sizeThatFits(CGSize(width: $0.frame.size.width, height: textViewMaxHeight))
        $0.keyboardDistanceFromTextField = 50 // 키보드 위치
        $0.becomeFirstResponder()
    }
    
    let addImageButton = UIButton().then {
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
        $0.tintColor = .black
    }
    
    let addVoiceButton = UIButton().then {
        $0.setImage(UIImage(systemName: "mic"), for: .normal)
        $0.tintColor = .black
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("cancelButton".localized, for: .normal)
        $0.titleLabel?.font = .appleSDGothicNeo(of: .content, weight: .medium)
        $0.setTitleColor(.systemGray3, for: .normal)
        
    }
    
    let finishReviewButton = UIButton().then {
        $0.setTitle("finishReviewButton".localized, for: .normal)
        $0.titleLabel?.font = .appleSDGothicNeo(of: .content, weight: .bold)
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(red: 199/255, green: 156/255, blue: 255/255, alpha: 1)
        $0.layer.cornerRadius = 6
    }
    
    override func setupUI() {
        backgroundColor = .clear
        
        self.addSubview(backgroundView)
        //stackView.addSubview(photoCollectionView)
        //stackView.addSubview(userTextView)
        
        //backgroundView.addSubview(stackView)
        backgroundView.addSubview(userTextView)
        
        backgroundView.addSubview(addImageButton)
        backgroundView.addSubview(addVoiceButton)
        backgroundView.addSubview(cancelButton)
        backgroundView.addSubview(finishReviewButton)
        
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(160)
            
        }

        userTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
            make.height.equalTo(userTextView.snp.height)
        }

        addImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(userTextView.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(40)
        }
        addVoiceButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.leading.equalTo(addImageButton.snp.trailing).offset(20)
            make.centerY.bottom.equalTo(addImageButton)
            
        }
        
        finishReviewButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.centerY.bottom.equalTo(addImageButton)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalTo(finishReviewButton.snp.leading).offset(-20)
            make.width.equalTo(48)
            make.height.equalTo(30)
            make.centerY.equalTo(addImageButton)
        }
    }
}

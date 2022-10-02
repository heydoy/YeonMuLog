//
//  VoiceMemoView.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/02.
//

import UIKit

final class VoiceMemoView: BaseView {
    private let characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "character-mic-recording")
    }
    
    let recordTimeLabel = UILabel().then {
        $0.font = .appleSDGothicNeo(of: .biggestTitle, weight: .bold)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "00:00.00"
    }
    
    let playButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.fill"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 50), forImageIn: .normal)
        $0.tintColor = UIColor(red: 199/255, green: 156/255, blue: 255/255, alpha: 1)
        $0.isHidden = true
    }
    
    let pauseButton = UIButton().then {
        $0.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        $0.tintColor = UIColor(red: 199/255, green: 156/255, blue: 255/255, alpha: 1)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 50), forImageIn: .normal)
        $0.isHidden = false
    }
    
    let closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 16), forImageIn: .normal)
        $0.tintColor = .black
    }
    
    let finishButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .appleSDGothicNeo(of: .title, weight: .semibold)
        $0.setTitleColor(UIColor(red: 199/255, green: 156/255, blue: 255/255, alpha: 1), for: .normal)
    }

    override func setupUI() {
        backgroundColor = .white
        addSubview(characterImageView)
        addSubview(recordTimeLabel)
        addSubview(playButton)
        addSubview(pauseButton)
        addSubview(closeButton)
        addSubview(finishButton)
    }
    
    override func setConstraints() {
        
        closeButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        finishButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(20)
            make.width.equalTo(30)
            make.height.equalTo(24)
        }
        characterImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
        }
        recordTimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(characterImageView.snp.bottom).offset(8)
        }
        
        pauseButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(recordTimeLabel.snp.bottom).offset(16)
        }
        playButton.snp.makeConstraints { make in
            make.centerX.top.width.height.equalTo(pauseButton)
        }
        
    }
}

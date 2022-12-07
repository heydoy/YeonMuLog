//
//  AddReviewViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/28.
//

import UIKit
import SnapKit
import YPImagePicker
import Realm
import Toast
import SwipeableTabBarController

protocol recordVoiceMemoDelegate: AnyObject {
    func sendVoiceMemo(url: String)
}

class AddReviewViewController: BaseViewController {
    // MARK: - Properties
    let mainView = AddReviewView()
    var config = YPImagePickerConfiguration()
    lazy var picker = YPImagePicker(configuration: config)
    
    var delegate: sendReviewDelegate?
    
    var voiceMemo: String = ""
    var text: String = ""
    var image: [String] = []
    
    var playInfo: UserPlayInfo?
    
    let repository = UserPlayRepository.shared
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarSwipe(enabled: false)
        
    }
    
    // MARK: - Actions
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func finishReviewButtonTapped(_ sender: UIButton) {
        
        if playInfo != nil && !mainView.userTextView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            // 사용자 인터랙션 비활성화
            self.mainView.isUserInteractionEnabled = false
            
            // 저장
            let review = UserReview()
            review.text = mainView.userTextView.text
            review.voice = voiceMemo
            review.date = Date()
            if !image.isEmpty {
                review.image.append(objectsIn: image)
            }
            repository.updateReview(playInfo!, review: review)
            
            // 완료 토스트
            showFinishToast(title: "addReviewSuccess".localized, message: "addReviewSuccessfully".localized, imageName: "character-pencil-finished") { _ in
                self.delegate?.reviewDataReload()
                self.dismiss(animated: true)
                
                // 사용자 인터랙션 재활성화
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.mainView.isUserInteractionEnabled = true
                }
            }
            
        } else {
            print("저장할 수 없습니다.")
            self.mainView.makeToast("내용이 없어 저장할 수 없습니다.")
        }
        
    }
    private func showFinishToast(title: String?, message: String?, imageName: String, completion: ((Bool) -> Void)?) {
        var style = ToastStyle()
        style.backgroundColor = .CustomColor.purple30
        style.maxWidthPercentage = 0.8
        let fontColor = UIColor.CustomColor.purple800
        style.titleColor = fontColor
        style.messageColor = fontColor
        style.imageSize = CGSize(width: 80, height: 80)
        style.titleFont = .appleSDGothicNeo(of: .subTitle, weight: .medium)
        style.messageFont = .appleSDGothicNeo(of: .content, weight: .regular)
        self.mainView.makeToast(message, duration: 0.8, position: .bottom, title: title, image: UIImage(named: imageName), style: style, completion: completion)
        
    }
    
    // MARK: - Helpers
//    func imagePickerConfigure() {
//        config.library.numberOfItemsInRow = 4
//        config.library.maxNumberOfItems = 4 //이미 선택된 사진 개수만큼 제외
//        config.library.mediaType = .photo
//        config.albumName = "YeonMuLog"
//    }
    
    override func configure() {
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        mainView.userTextView.delegate = self
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.finishReviewButton.addTarget(self, action: #selector(finishReviewButtonTapped), for: .touchUpInside)
    }
}

extension AddReviewViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if presentedViewController == self {
            return false
        } else {
            return true
        }
    }
}

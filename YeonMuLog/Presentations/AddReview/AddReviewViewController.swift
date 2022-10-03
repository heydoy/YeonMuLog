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

protocol recordVoiceMemoDelegate {
    func sendVoiceMemo(url: String)
}

class AddReviewViewController: BaseViewController {
    // MARK: - Properties
    let mainView = AddReviewView()
    var config = YPImagePickerConfiguration()
    lazy var picker = YPImagePicker(configuration: config)
    
    var voiceMemo: String = ""
    var text: String = ""
    var image: [String] = []
    
    var playInfo: UserPlayInfo?
    let review = UserReview()
    
    let repository = UserPlayRepository.shared
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerConfigure()
    }
    
    // MARK: - Actions

    @objc func addGalleryButtonTapped(_ sender: UIButton) {
        print("사진추가")
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.modifiedImage)
            }
            for item in items {
                switch item {
                case .photo(let photo):
                    print(photo.url, photo.modifiedImage)
                    if let url = photo.url {
                        self.image.append("\(url)")
                    }
                    
                default:
                    print("사진만 첨부할 수 있습니다.")
                }
            }
            picker.dismiss(animated: true, completion: nil)
            
        }
        
        present(picker, animated: true, completion: nil)

    }
    
    @objc func addVoiceButtonTapped(_ sender: UIButton) {
        print("음성메모")
        let vc = VoiceMemoViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func finishReviewButtonTapped(_ sender: UIButton) {
        
        
        if let playInfo = playInfo, !text.isEmpty {
            review.text = mainView.userTextView.text
            review.voice = voiceMemo
            review.image.append(objectsIn: [])
            
            repository.updateReview(playInfo, review: review)
        }
        
    }
    
    // MARK: - Helpers
    func imagePickerConfigure() {
        config.library.numberOfItemsInRow = 4
        config.library.maxNumberOfItems = 4 //이미 선택된 사진 개수만큼 제외 
        config.library.mediaType = .photo
        config.albumName = "YeonMuLog"
    }
    
    override func configure() {
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        mainView.userTextView.delegate = self
            
        mainView.addGalleryButton.addTarget(self, action: #selector(addGalleryButtonTapped), for: .touchUpInside)
        mainView.addVoiceButton.addTarget(self, action: #selector(addVoiceButtonTapped), for: .touchUpInside)
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

// MARK: - 음성메모를 전달받기 위한 프로토콜 상속
extension AddReviewViewController: recordVoiceMemoDelegate {
    /// 음성메모를 presenting vc에 보내는 메서드 
    func sendVoiceMemo(url: String) {
        voiceMemo = url
        print(url, voiceMemo)
        if !voiceMemo.isEmpty {
            // 아이콘 디자인 변경
            
        }
    }
}

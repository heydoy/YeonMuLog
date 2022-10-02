//
//  AddReviewViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/28.
//

import UIKit
import SnapKit
import YPImagePicker

class AddReviewViewController: BaseViewController {
    // MARK: - Properties
    let mainView = AddReviewView()
    var config = YPImagePickerConfiguration()
    lazy var picker = YPImagePicker(configuration: config)
    
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
                  print(photo.fromCamera) // Image source (camera or library)
                  print(photo.image) // Final image selected by the user
                  print(photo.originalImage) // original image selected by the user, unfiltered
                  print(photo.modifiedImage) // Transformed image, can be nil
                  print(photo.exifMeta) // Print exif meta data of original image.
              }
              picker.dismiss(animated: true, completion: nil)
            
          }
        
        present(picker, animated: true, completion: nil)

    }
    
    @objc func addVoiceButtonTapped(_ sender: UIButton) {
        print("음성메모")
        let vc = VoiceMemoViewController()
        present(vc, animated: true)
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func finishReviewButtonTapped(_ sender: UIButton) {
        print("리뷰작성완료")
        dismiss(animated: true)
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



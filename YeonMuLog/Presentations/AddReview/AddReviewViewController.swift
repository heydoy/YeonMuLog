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
    let picker = UIImagePickerController()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @objc func addCameraButtonTapped(_ sender: UIButton) {
        print("사진촬영")
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }

    @objc func addGalleryButtonTapped(_ sender: UIButton) {
        print("사진추가")
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    @objc func addVoiceButtonTapped(_ sender: UIButton) {
        print("음성메모")
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func finishReviewButtonTapped(_ sender: UIButton) {
        print("리뷰작성완료")
    }
    
    // MARK: - Helpers
    override func configure() {
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        mainView.userTextView.delegate = self
            
        mainView.addCameraButton.addTarget(self, action: #selector(addCameraButtonTapped), for: .touchUpInside)
        mainView.addGalleryButton.addTarget(self, action: #selector(addGalleryButtonTapped), for: .touchUpInside)
        mainView.addVoiceButton.addTarget(self, action: #selector(addVoiceButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.finishReviewButton.addTarget(self, action: #selector(finishReviewButtonTapped), for: .touchUpInside)
        
        picker.delegate = self
       
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

// MARK: - YPImagePicker
extension AddReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // - 사진선택, 카메라 촬영 직후에
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true)
        }
    }
    
    // - 취소 버튼 눌렀을 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        
        dismiss(animated: true)
    }
}

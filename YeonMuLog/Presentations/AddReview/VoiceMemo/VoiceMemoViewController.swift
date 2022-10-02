//
//  VoiceMemoViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/02.
//

import UIKit

class VoiceMemoViewController: BaseViewController {
    // MARK: - Properties
    
    let mainView = VoiceMemoView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @objc func pauseButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func finishButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        
    }
    
    
    // MARK: - Helpers
    override func configure() {
        mainView.pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        mainView.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        mainView.finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}

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
    
    // MARK: - Helpers
    

}

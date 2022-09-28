//
//  AddReviewViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/28.
//

import UIKit

class AddReviewViewController: BaseViewController {
    // MARK: - Properties
    let mainView = AddReviewView()
    
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

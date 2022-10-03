//
//  SettingViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/04.
//

import UIKit

class SettingViewController: BaseViewController {
    
    // MARK: - Properties
    let mainView = SettingView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    override func setNavigationBar() {
        navigationItem.title = "settingTabName".localized
    }

}

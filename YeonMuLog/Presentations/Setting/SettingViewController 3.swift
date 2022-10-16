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
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.value1, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        let setting = SettingInfo.list[indexPath.section]
        cell.textLabel?.text = setting.text
        cell.detailTextLabel?.text = setting.detailText
        cell.imageView?.image = UIImage(systemName: setting.image)
        cell.imageView?.tintColor = .black
        if indexPath.section == 0 {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "앱 정보" : "문의"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let instagram = "https://www.instagram.com/yeonmulog"
            
            let instagramURL = NSURL(string: instagram)
                    
                if UIApplication.shared.canOpenURL(instagramURL! as URL) {
                    UIApplication.shared.open(
                    instagramURL! as URL,
                    options: [:],
                    completionHandler: nil
                    )
                }
        }
    }
}

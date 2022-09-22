//
//  AddWatchedViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

class AddWatchedViewController: BaseViewController {
    // MARK: - Properties
    let mainView = AddWatchedView()
    var playInfo: Play? 
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @objc func finishButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    // MARK: - Helpers
    override func setNavigationBar() {
        navigationItem.title = "AddWatchedNavigationTitle".localized
        let finish = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(finishButtonTapped))
        navigationItem.rightBarButtonItem = finish
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

// MARK: - Table View
extension AddWatchedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

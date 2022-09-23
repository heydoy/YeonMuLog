//
//  TaraeViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

class TaraeViewController: BaseViewController {
    // MARK: - Properties
    let mainView = TaraeView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @objc func searchAndAddButtonTapped(_ sender: UIBarButtonItem) {
        let vc = SearchPlayViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helpers
    
    override func setNavigationBar() {
        navigationItem.title = "타래로 보기"
        
        let searchAndAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchAndAddButtonTapped))
        searchAndAdd.tintColor = .black
        navigationItem.backButtonTitle = ""
        
        navigationItem.rightBarButtonItem = searchAndAdd
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(NoReviewTableViewCell.self, forCellReuseIdentifier: String(describing: NoReviewTableViewCell.self))
    }
}

// MARK: - Table View

extension TaraeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoReviewTableViewCell.self)) as? NoReviewTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

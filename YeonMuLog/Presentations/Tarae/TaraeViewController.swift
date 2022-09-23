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
        
        navigationItem.rightBarButtonItem = searchAndAdd
    }

}

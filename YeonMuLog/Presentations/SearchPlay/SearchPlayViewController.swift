//
//  SearchPlayViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import UIKit

class SearchPlayViewController: BaseViewController {
    // MARK: - Properties
    let searchBar = UISearchBar()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    // MARK: - Actions
    @objc
    func navigationCancelButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Helpers
    override func setNavigationBar() {
        // Search Bar 설정
        searchBar.placeholder = "극 제목으로 검색"
        navigationItem.titleView = searchBar
        // 취소 버튼을 오른쪽에 추가
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(navigationCancelButtonTapped(_:)))
        navigationItem.rightBarButtonItem = cancel

    }
}


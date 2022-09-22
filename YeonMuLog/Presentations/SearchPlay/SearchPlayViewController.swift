//
//  SearchPlayViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import UIKit

class SearchPlayViewController: BaseViewController {
    // MARK: - Properties
    let mainView = SearchPlayView()
    let searchBar = UISearchBar()
    var list: [Play] = []
    var query = String()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = Play(id: "PF333333", title: "마리 퀴리", cast: "김소향, 옥주현, 김히어라, 이봄소리, 양승리, 김찬호, 박영수 등", genre: "뮤지컬", poster: "http://www.kopis.or.kr/upload/pfmPoster/PF_PF165402_200702_093020.PNG", place: "홍익대 대학로 아트센터", startDate: "2020.07.30", endDate: "2020.09.27", runtime: "2시간 30분", ticket: "", time: "")
        list.append(item)
    }
        
    // MARK: - Actions
    @objc func navigationCancelButtonTapped(_ sender: UIBarButtonItem) {
        
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
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchPlayResultTableViewCell.self, forCellReuseIdentifier: String(describing: SearchPlayResultTableViewCell.self))
        mainView.tableView.register(AddPlayInfoTableViewCell.self, forCellReuseIdentifier: String(describing: AddPlayInfoTableViewCell.self))
    }
}

// MARK: - TableView
extension SearchPlayViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? list.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchPlayResultTableViewCell.self)) as? SearchPlayResultTableViewCell else { return UITableViewCell() }
            cell.setData(data: list[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddPlayInfoTableViewCell.self)) as? AddPlayInfoTableViewCell else { return UITableViewCell() }

            return cell
        }
    }
}

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
    var list: [Play] = [] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    var query = String() {
        didSet {
            searchQuery(query: query)
        }
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        let item = Play(id: "PF333333", title: "마리 퀴리", cast: "김소향, 옥주현, 김히어라, 이봄소리, 양승리, 김찬호, 박영수 등", genre: "뮤지컬", poster: "http://www.kopis.or.kr/upload/pfmPoster/PF_PF165402_200702_093020.PNG", place: "홍익대 대학로 아트센터", startDate: "2020.07.30", endDate: "2020.09.27", runtime: "2시간 30분", ticket: "", time: "")
//        list.append(item)
        
        //searchQuery(query: "키다리")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
        
    // MARK: - Actions
    @objc func navigationCancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func searchQuery(query: String) {
        KOPISAPIManager.shared.callList(query: query) { result in
            switch result {
            case let .success(result):
                self.list = result
            case let .failure(error):
                // 사용자에게 메시지
                print(error)
            }
        }
    }
    
    // MARK: - Helpers
    override func setNavigationBar() {
        super.setNavigationBar()
        // Search Bar 설정
        searchBar.placeholder = "극 제목으로 검색"
        navigationItem.titleView = searchBar
        // 취소 버튼을 오른쪽에 추가
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(navigationCancelButtonTapped(_:)))
        navigationItem.rightBarButtonItem = cancel
    }
    override func configure() {
        searchBar.delegate = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchPlayResultTableViewCell.self, forCellReuseIdentifier: String(describing: SearchPlayResultTableViewCell.self))
        mainView.tableView.register(AddPlayInfoTableViewCell.self, forCellReuseIdentifier: String(describing: AddPlayInfoTableViewCell.self))
        mainView.tableView.register(FirstSearchPlayTableViewCell.self, forCellReuseIdentifier: String(describing: FirstSearchPlayTableViewCell.self))
        mainView.tableView.register(NoSearchResultTableViewCell.self, forCellReuseIdentifier: String(describing: NoSearchResultTableViewCell.self))
    }
}

// MARK: - TableView
extension SearchPlayViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return query.isEmpty ? 1 : list.isEmpty ? 1 : 2 // 검색어 여부로 첫 진입 체크, 검색어는 있지만 리스트가 비었을경우 검색어없는 표시
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return query.isEmpty ? 1 : list.isEmpty ? 1 : section == 0 ? list.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if query.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FirstSearchPlayTableViewCell.self)) as? FirstSearchPlayTableViewCell else { return UITableViewCell() }
            return cell
        } else if !query.isEmpty && list.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoSearchResultTableViewCell.self)) as? NoSearchResultTableViewCell else { return UITableViewCell() }
            cell.setData(query: query)
            return cell
        } else {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !list.isEmpty && indexPath.section == 0 {
            let vc = AddWatchedViewController()
            vc.playInfo = list[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - Search Bar Delegate

extension SearchPlayViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let query = searchBar.text, !query.isEmpty else {
            // 텍스트가 없을 경우 사용자에게 안내하기
            print("서치바에 글자가 없습니다.")
            return
        }
        self.query = query
    }
}

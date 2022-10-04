//
//  TaraeViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import RealmSwift

class TaraeViewController: BaseViewController {
    // MARK: - Properties
    let mainView = TaraeView()
    let repository = UserPlayRepository.shared
    var list: Results<UserPlayInfo>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if repository.fetch() != list {
            list = repository.fetch()
       }
    }
    
    // MARK: - Actions
    @objc func searchAndAddButtonTapped() {
        let vc = SearchPlayViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helpers
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
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
        
        mainView.tableView.register(TaraeReviewTableViewCell.self, forCellReuseIdentifier: String(describing: TaraeReviewTableViewCell.self))
    }
}

// MARK: - Table View

extension TaraeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list == nil || list.count == 0 ? 1 : list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if list == nil || list.count == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoReviewTableViewCell.self)) as? NoReviewTableViewCell else { return UITableViewCell() }
        
        return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaraeReviewTableViewCell.self)) as? TaraeReviewTableViewCell else { return UITableViewCell() }
            
            cell.setData(data: list[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if list == nil || list.count == 0 {
            searchAndAddButtonTapped()
        } else {
            let vc = TaraeDetailViewController()
            // vc에 데이터 전달
            vc.playInfo = list[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

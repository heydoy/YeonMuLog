//
//  TaraeViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import RealmSwift
import Toast

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
        navigationItem.title = "mainTabName".localized
        
        // 오른쪽 바버튼
        let searchAndAdd = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(searchAndAddButtonTapped))
        searchAndAdd.tintColor = .black
        navigationItem.backButtonTitle = ""
        
        navigationItem.rightBarButtonItem = searchAndAdd
        
        // 왼쪽 바버튼
        // - 정렬
        let sortMenuItems: [UIAction] =  [
            UIAction(title: "sortByLatest".localized, handler: { [weak self] _ in
                self?.list = self?.repository.fetchWith(sort: .date, option: false)
            }),
            UIAction(title: "sortByOldest".localized, handler: { [weak self] _ in
                self?.list = self?.repository.fetchWith(sort: .date, option: true)
            }),
            UIAction(title: "sortByAlphabetical".localized, handler: { [weak self] _ in
                self?.list = self?.repository.fetchWith(sort: .title, option: true)
            }),
            UIAction(title: "sortByReverseAlphabetical".localized, handler: { [weak self] _ in
                self?.list = self?.repository.fetchWith(sort: .title, option: false)
            })
            
        ]
    
        let sortMenu = UIMenu(
            title: "sortBy".localized,
            image: nil,
            identifier: nil,
            options: [],
            children: sortMenuItems)

        let sort = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            menu: sortMenu)
        
        // - 검색
        let search = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTapped(_:)))
        
        navigationItem.leftBarButtonItems = [sort, search]
        
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(NoReviewTableViewCell.self, forCellReuseIdentifier: String(describing: NoReviewTableViewCell.self))
        
        mainView.tableView.register(TaraeReviewTableViewCell.self, forCellReuseIdentifier: String(describing: TaraeReviewTableViewCell.self))
    }
    // MARK: - Actions
        @objc
        func searchButtonTapped(_ sender: UIBarButtonItem) {
            // 텍스트필드가 있는 얼럿을 띄우고 검색하기
            let searchAlert = UIAlertController(
                title: "searchWatchedAlertTitle".localized,
                message: "searchWatchedAlertMessage".localized,
                preferredStyle: .alert)
            
            let search = UIAlertAction(
                title: "searchButtonTitle".localized,
                style: .default) { [weak self] _ in
                    var style = ToastStyle()
                    style.backgroundColor = .CustomColor.purple30
                    let fontColor = UIColor.CustomColor.purple800
                    style.titleColor = fontColor
                    style.messageColor = fontColor
                    style.imageSize = CGSize(width: 80, height: 80)
                    style.titleFont = .appleSDGothicNeo(of: .title, weight: .medium)
                    style.messageFont = .appleSDGothicNeo(of: .subTitle, weight: .regular)
                    
                    // 검색어가 없을 시
                    guard let text = searchAlert.textFields?[0].text, !text.isEmpty else {
                        self?.view.makeToast("검색어를 제대로 입력해주세요", duration: 0.75, position: .center, title: nil, image: nil, style: style, completion: nil)
                        return
                    }
                    // 검색결과가 없을 시
                    guard let list = self?.repository.fetchFilter(text), !list.isEmpty else {
                        self?.view.makeToast("\(text)에 해당하는 결과가 없습니다.", duration: 0.75, position: .center, title: nil, image: nil, style: style, completion: nil)
                        return
                    }
                    // 검색결과를 리스트에 넣고, 알려줌
                    self?.list = list
                    self?.view.makeToast("\(text)에 해당하는 결과가 \(list.count)건 있습니다.", duration: 0.75, position: .center, title: nil, image: nil, style: style, completion: nil)
                }
            
            let cancel = UIAlertAction(
                title: "cancelButton".localized,
                style: .cancel)
            
            searchAlert.addTextField { textField in
                textField.placeholder = "searchWatchedAlertTextFieldPlaceHolder".localized
            }
            
            searchAlert.addAction(search)
            searchAlert.addAction(cancel)
            
            present(searchAlert, animated: true)
            
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
    
    // Swipe Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            
            let remove = UIAlertAction(title: "삭제", style: .destructive) { _ in
                if let item = self?.list[indexPath.row] {
                    
                    self?.repository.deletePlay(item)
                    self?.mainView.makeToast("관극기록이 삭제되었습니다.", duration: 1.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                    
                    self?.list = self?.repository.fetch()
                }
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            self?.showAlert(title: "관극기록을 삭제하시겠습니까?", message: "삭제하시면 리뷰도 전부 삭제됩니다", actions: remove, cancel)
            
        }
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

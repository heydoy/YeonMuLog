//
//  TaraeDetailViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/25.
//

import UIKit
import RealmSwift
import Toast
import SwipeableTabBarController

enum TaraeDetailSection: Int, CaseIterable {
    case playInfo = 0
    case review
}

protocol sendReviewDelegate: AnyObject {
    func reviewDataReload(_ reviewMode: ReviewMode)
    func editReview(reviewID: ObjectId, userReview: UserReview)
}

class TaraeDetailViewController: BaseViewController {
    // MARK: - Properties
    
    let mainView = TaraeDetailView()
    
    let repository = UserPlayRepository.shared
    
    var playInfo: UserPlayInfo? {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTabBarSwipe(enabled: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Actions
    
    @objc func addReviewButtonTapped(_ sender: UIButton) {
        let vc = AddReviewViewController()
        vc.playInfo = playInfo
        vc.reviewMode = .create
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func editReview(_ reviewIndex: Int) {
        
        if let review = playInfo?.userReview[reviewIndex] {
            
            let vc = AddReviewViewController()
            vc.playInfo = playInfo
            vc.reviewMode = .edit
            vc.review = review
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            present(vc, animated: true)
        } else {
            mainView.makeToast("redoPlease".localized)
        }
    }
    
    func removeReview(_ reviewIndex: Int) {
        if let review = playInfo?.userReview[reviewIndex] {
            
            repository.removeReview(review)
            mainView.makeToast("removeReview".localized, duration: 1.0, position: .bottom, title: nil, image: nil, style: ToastStyle(), completion: nil)
            if let item = repository.fetchById(playInfo!.id) {
                playInfo = item
            }
            
        }
    }
    
    @objc func goUpButtonTapped(_ sender: UIButton) {
        mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: TaraeDetailSection.playInfo.rawValue), at: .bottom, animated: false)
    }
    
    // MARK: - Helpers
    override func setNavigationBar() {
        super.setNavigationBar()
        
        navigationItem.title = "detailPlayInfoThread".localized
        
        let menuItems = [
            
            UIAction(title: "RemoveUserPlay".localized, image: UIImage(systemName: "trash"), attributes: .destructive, handler: { [weak self] _ in
                
                let remove = UIAlertAction(title: "Remove".localized, style: .destructive) { _ in
                    if let playInfo = self?.playInfo {
                        self?.repository.deletePlay(playInfo)
                        self?.mainView.makeToast("recordRemoved".localized, duration: 1.0, position: .top, title: nil, image: nil, style: ToastStyle()) { didTap in
                            self?.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                }
                let cancel = UIAlertAction(title: "cancelButton".localized, style: .cancel)
                
                self?.showAlert(title: "doYouRemoveRecord".localized, message: "itWouldAlsoRemoveReview".localized, actions: remove, cancel)
                
            })
        ]
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [.singleSelection], children: menuItems)
        
        let editImage = UIImage(named: "dot.3.icon")
        
        let editAndRemove = UIBarButtonItem(title: nil, image: editImage, primaryAction: nil, menu: menu)
        
        navigationItem.rightBarButtonItem = editAndRemove
        
    }
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(TaraeDetailPlayInfoTableViewCell.self, forCellReuseIdentifier: String(describing: TaraeDetailPlayInfoTableViewCell.self))
        
        mainView.tableView.register(TaraeDetailReviewTableViewCell.self, forCellReuseIdentifier: String(describing: TaraeDetailReviewTableViewCell.self))
        
        mainView.tableView.register(NoReviewInRecordTableViewCell.self, forCellReuseIdentifier: String(describing: NoReviewInRecordTableViewCell.self))
        
        mainView.addReviewButton.addTarget(self, action: #selector(addReviewButtonTapped), for: .touchUpInside)
        mainView.goUpbutton.addTarget(self, action: #selector(goUpButtonTapped), for: .touchUpInside)
    }
}
extension TaraeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TaraeDetailSection.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TaraeDetailSection.playInfo.rawValue {
            return 1
        } else if section == TaraeDetailSection.review.rawValue {
            return playInfo?.userReview.count != 0 ? playInfo!.userReview.count : 1
        } else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == TaraeDetailSection.playInfo.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaraeDetailPlayInfoTableViewCell.self)) as? TaraeDetailPlayInfoTableViewCell else { return UITableViewCell() }
            print("TaraeDetailPlayInfoTableViewCell")
            
            if let data = playInfo {
                cell.setData(data: data)
            }
            return cell
            
        } else if indexPath.section == TaraeDetailSection.review.rawValue {
            if playInfo?.userReview.count != 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaraeDetailReviewTableViewCell.self)) as? TaraeDetailReviewTableViewCell else { return UITableViewCell() }
                
                cell.setData(review: playInfo!.userReview[indexPath.item])
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoReviewInRecordTableViewCell.self), for: indexPath) as? NoReviewInRecordTableViewCell else { return UITableViewCell() }
                
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // ??????????????????
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == TaraeDetailSection.review.rawValue {
            let remove = UIContextualAction(style: .normal, title: nil) { [weak self]_, _, _ in
                
                self?.removeReview(indexPath.item)
            }
            remove.backgroundColor = UIColor.systemPink
            remove.image = UIImage(systemName: "trash.fill")
            
            return UISwipeActionsConfiguration(actions: [remove])
        } else {
            return nil
        }
    }
    // ??? ?????? ???
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == TaraeDetailSection.review.rawValue {
            editReview(indexPath.item)
        }
    }
}

extension TaraeDetailViewController: sendReviewDelegate {
    func editReview(reviewID: ObjectId, userReview: UserReview) {
        repository.editReview(playInfo!, reviewID: reviewID, userReview: userReview)
    }
    
    func reviewDataReload(_ reviewMode: ReviewMode) {
        if let playInfo = playInfo {
            let newPlayInfo = repository.localRealm.object(ofType: UserPlayInfo.self, forPrimaryKey: playInfo.id)
            self.playInfo = newPlayInfo
            mainView.tableView.reloadData()
            if reviewMode == .create {
                mainView.tableView.scrollToRow(at: IndexPath(row: playInfo.userReview.count - 1, section: TaraeDetailSection.review.rawValue), at: .bottom, animated: false)
                
            }
        }
    }
}

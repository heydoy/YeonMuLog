//
//  TaraeDetailViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/25.
//

import UIKit

enum TaraeDetailSection: Int {
    case playInfo = 0
    case review = 1
    
    func getHeight() -> CGFloat {
        switch self {
        case .playInfo :
            return 500
        case .review :
            return UIScreen.main.bounds.height - 500
        }
    }
}

class TaraeDetailViewController: BaseViewController {
    // MARK: - Properties
    
    let mainView = TaraeDetailView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    override func setNavigationBar() {
        super.setNavigationBar()
        
        navigationItem.title = "스레드"
        
        let menuItems = [
            UIAction(title: "EditPlayInfo".localized, image: UIImage(systemName: "square.and.pencil"), handler: { _ in
                // code
            }),
            UIAction(title: "RemoveUserPlay".localized, image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
                //code
                
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
        
        mainView.tableView.register(TaraeDetailReviewTableViewCell.self,  forCellReuseIdentifier: String(describing: TaraeDetailReviewTableViewCell.self))
    }
}
extension TaraeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TaraeDetailSection.playInfo.rawValue {
            return 1
        } else if section == TaraeDetailSection.review.rawValue {
            return 1 
        } else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == TaraeDetailSection.playInfo.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaraeDetailPlayInfoTableViewCell.self)) as? TaraeDetailPlayInfoTableViewCell else { return UITableViewCell() }
            print("TaraeDetailPlayInfoTableViewCell")
            
            return cell
            
        } else if indexPath.section == TaraeDetailSection.review.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaraeDetailReviewTableViewCell.self)) as? TaraeDetailReviewTableViewCell else { return UITableViewCell() }

            cell.flowLayout.delegate = self
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == TaraeDetailSection.playInfo.rawValue ? TaraeDetailSection.playInfo.getHeight() : TaraeDetailSection.review.getHeight()
    }
}

extension TaraeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension TaraeDetailViewController: ReviewCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForCellAt indexPath: IndexPath) -> CGFloat {
        return  .zero
    }
}

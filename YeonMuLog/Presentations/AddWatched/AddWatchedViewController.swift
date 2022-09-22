//
//  AddWatchedViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit

enum AddWatchedItem: Int {
    case posterGenreTitle = 0
    case date
    case place
    case cast
    case seat
    case ticketPrice
    
    func getTitle() -> String {
        switch self {
        case .posterGenreTitle:
            return ""
        case .date:
            return "관람일자"
        case .place:
            return "장소"
        case .cast:
            return "캐스팅"
        case .seat:
            return "좌석"
        case .ticketPrice:
            return "가격"
        }
    }
}

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
        
        print(playInfo)
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
        
        mainView.tableView.register(WatchedPosterGenreTitleTableViewCell.self, forCellReuseIdentifier: String(describing: WatchedPosterGenreTitleTableViewCell.self))
        
        mainView.tableView.register(WatchedTextFieldTableViewCell.self, forCellReuseIdentifier: String(describing: WatchedTextFieldTableViewCell.self))
    }
}

// MARK: - Table View
extension AddWatchedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        switch indexPath.row {
        case AddWatchedItem.posterGenreTitle.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedPosterGenreTitleTableViewCell.self)) as? WatchedPosterGenreTitleTableViewCell else { return UITableViewCell() }
            
            if let play = playInfo {
                cell.setData(data: play)
            }
            return cell
        case AddWatchedItem.date.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTextFieldTableViewCell.self)) as? WatchedTextFieldTableViewCell else { return UITableViewCell() }
            
            cell.setData(
                title: AddWatchedItem.date.getTitle(),
                textFieldText: "2022년 9월 23일 오후 8시",
                placeHolder: "")
            
            return cell
        case AddWatchedItem.place.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTextFieldTableViewCell.self)) as? WatchedTextFieldTableViewCell else { return UITableViewCell() }
            
            if let play = playInfo {
                cell.setData(
                    title: AddWatchedItem.place.getTitle(),
                    textFieldText: play.place,
                    placeHolder: "관람한 장소를 입력해주세요")
            }
            
            return cell
            
        case AddWatchedItem.cast.rawValue:
            return UITableViewCell()
            
        case AddWatchedItem.seat.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTextFieldTableViewCell.self)) as? WatchedTextFieldTableViewCell else { return UITableViewCell() }
            
            cell.setData(
                title: AddWatchedItem.seat.getTitle(),
                textFieldText: "",
                placeHolder: "좌석위치를 입력해주세요")
            
            return cell
            
        case AddWatchedItem.ticketPrice.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTextFieldTableViewCell.self)) as? WatchedTextFieldTableViewCell else { return UITableViewCell() }
            
            cell.setData(
                title: AddWatchedItem.ticketPrice.getTitle(),
                textFieldText: "",
                placeHolder: "티켓금액을 입력해주세요")
            
            return cell
                
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 470 : indexPath.row == 3 ?  UITableView.automaticDimension : 80 // size automatic dimension이 안되서 수동으로 해줘야되는 이유를 찾아야...
    }
}

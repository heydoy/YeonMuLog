//
//  AddWatchedViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import UIKit
import RealmSwift
import Toast

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
    let repository = UserPlayRepository.shared
    var playInfo: Play? 
    var castArray: [String] = []
    var castSelectedIndex: [Int] = []
    var castSelectedData: [String] = []
        
    var seat: String = ""
    var ticketPrice: Int = 0
    var watchedDate = Date()
    
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
        saveUserPlayInfo()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func seatValueChanged(_ sender: UITextField) {
        if let text = sender.text {
            seat = text
        }
    }
    
    @objc func ticketPriceValueChanged(_ sender: UITextField) {

        if let text = sender.text {
            if let price = Int(text) {
                ticketPrice = price
            } else {
                self.mainView.makeToast("숫자만 입력해주세요")
                sender.text = nil
            }
        }
    }
    
    @objc func selectWatchedDate(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            print(datePicker.date)
            self.watchedDate = datePicker.date
            self.mainView.tableView.reloadRows(at: [IndexPath(row: AddWatchedItem.date.rawValue, section: 0)], with: .none)
        }
        alert.addAction(ok)
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 400)
        let width: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width * 0.92)
        
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        present(alert, animated: true)
    }
    
    func saveUserPlayInfo() {
        let list = UserPlayInfo()
        if let play = playInfo {
            list.date = watchedDate
            list.casts.append(objectsIn: castSelectedData)

            list.playId = play.id
            list.genre = play.genre
            list.seat = seat
            list.ticket = ticketPrice
            list.poster = play.poster
            list.title = play.title
            list.place = play.place
            list.runtime = play.runtime
            
            let repository = UserPlayRepository()
            repository.createPlay(list)
        }
    }
    
    // MARK: - Helpers
    override func setNavigationBar() {
        super.setNavigationBar()
        
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
        
        mainView.tableView.register(WatchedTagsTableViewCell.self, forCellReuseIdentifier: String(describing: WatchedTagsTableViewCell.self))
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
                textFieldText: "\(watchedDate.playString())",   // "2022년 9월 23일 오후 8시"
                placeHolder: "")
            
            cell.userTextField.isEnabled = false
            
            return cell
        case AddWatchedItem.place.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTextFieldTableViewCell.self)) as? WatchedTextFieldTableViewCell else { return UITableViewCell() }
            
            if let play = playInfo {
                cell.setData(
                    title: AddWatchedItem.place.getTitle(),
                    textFieldText: play.place,
                    placeHolder: "관람한 장소를 입력해주세요")
            }
            
            cell.userTextField.isEnabled = false
            return cell
            
        case AddWatchedItem.cast.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTagsTableViewCell.self)) as? WatchedTagsTableViewCell else { return UITableViewCell() }
            
            cell.setData(title: AddWatchedItem.cast.getTitle())
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            return cell
            
        case AddWatchedItem.seat.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTextFieldTableViewCell.self)) as? WatchedTextFieldTableViewCell else { return UITableViewCell() }
            
            cell.setData(
                title: AddWatchedItem.seat.getTitle(),
                textFieldText: "",
                placeHolder: "좌석위치를 입력해주세요")
            
            cell.userTextField.addTarget(self, action: #selector(seatValueChanged), for: .valueChanged)
            cell.userTextField.isEnabled = true
            return cell
            
        case AddWatchedItem.ticketPrice.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatchedTextFieldTableViewCell.self)) as? WatchedTextFieldTableViewCell else { return UITableViewCell() }
            
            cell.userTextField.addTarget(self, action: #selector(ticketPriceValueChanged), for: .valueChanged)
            
            cell.setData(
                title: AddWatchedItem.ticketPrice.getTitle(),
                textFieldText: "",
                placeHolder: "티켓금액을 입력해주세요")
            
            cell.userTextField.keyboardType = .numberPad
            cell.userTextField.isEnabled = true
            return cell
                
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 400 : indexPath.row == 3 ?  140 : 80 // size automatic dimension이 안되서 수동으로 해줘야되는 이유를 찾아야...
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case AddWatchedItem.date.rawValue:
            guard let cell = tableView.cellForRow(at: indexPath) as? WatchedTextFieldTableViewCell else { return }
            selectWatchedDate(cell.userTextField)
            
        default:
            print("")
        }
    }
}

// MARK: - CollectionView

extension AddWatchedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let play = playInfo else { return 0 }
        castArray = play.cast.components(separatedBy: ", ")
        castArray = castArray.map {
           $0.replacingOccurrences(of: " 등", with: "")
        }
        return castArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TagCollectionViewCell.self), for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(title: castArray[indexPath.item])
        
        if castSelectedIndex.contains(indexPath.item) {
            cell.pressedDesign()
        } else {
            cell.defaultDesign()
        }
                

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let strData = castArray[indexPath.item]

        if castSelectedIndex.contains(indexPath.item) {
            castSelectedIndex = castSelectedIndex.filter { $0 != indexPath.item}
            castSelectedData = castSelectedData.filter { $0 != strData}
        } else {
            castSelectedIndex.append(indexPath.item)
            castSelectedData.append(strData)
        }

        print(#function, castSelectedData, castSelectedIndex)
        collectionView.reloadData()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        let width: CGFloat = castArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 25
        let height: CGFloat = 40
        
        return CGSize(width: width, height: height)
    }
}

//
//  ChartViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import UIKit
import RealmSwift

class ChartViewController: BaseViewController {

    // MARK: - Properties
    let mainView = ChartView()
    let repository = UserPlayRepository.shared
    var list: Results<UserPlayInfo>!
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    // MARK: - Helpers
    override func setNavigationBar() {
        navigationItem.title = "통계"
    }
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(NoChartTableViewCell.self, forCellReuseIdentifier: String(describing: NoChartTableViewCell.self))
    }
    
}
// MARK: - Table View
extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoChartTableViewCell.self)) as? NoChartTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

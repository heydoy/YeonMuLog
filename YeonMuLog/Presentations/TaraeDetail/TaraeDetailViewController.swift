//
//  TaraeDetailViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/25.
//

import UIKit

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
        navigationItem.title = "스레드"
        
        let menuItems = [
            UIAction(title: "EditPlayInfo".localized, image: UIImage(systemName: "square.and.pencil"), handler: { action in
                // code
            }),
            UIAction(title: "RemoveUserPlay".localized, image: UIImage(systemName: "trash"), attributes: .destructive, handler: { action in
                //code
            }),
        ]
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [.singleSelection], children: menuItems)
        
        let editImage = UIImage(named: "dot.3.icon")

        let editAndRemove = UIBarButtonItem(title: nil, image: editImage, primaryAction: nil, menu: menu)
        
        navigationItem.rightBarButtonItem = editAndRemove
        
    }
    override func configure() {
        <#code#>
    }

}

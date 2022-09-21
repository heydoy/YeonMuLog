//
//  BaseViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        configure()
        setNavigationBar()

    }
    
    func configure() { }
    func setNavigationBar() { }

}

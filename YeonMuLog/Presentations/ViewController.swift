//
//  ViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // KOPISAPIManager.shared.callList(query: "키다리")
        print("------------")
        KOPISAPIManager.shared.callDetail(id: "PF137090")
        KOPISAPIManager.shared.callDetail(id: "PF149989")
        KOPISAPIManager.shared.callDetail(id: "PF132236")
    }
}

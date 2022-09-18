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
        KOPISAPIManager.shared.callList(query: "뮹") { result in
            switch result {
            case let  .success(result):
                if result.isEmpty { print("뮹은 비었습니다.")}
                else {
                    print("결과", result)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        print("------------")
        KOPISAPIManager.shared.callList(query: "키다리") { result in
            switch result {
            case let  .success(result) :
                print("결과", result)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
  
    }
}

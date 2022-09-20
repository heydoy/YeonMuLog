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
        
        print("####-----------------------")
        let list = UserPlayInfo()
        list.date = Date()
        list.casts.append(objectsIn: ["소영", "윤소영", "지율"])

        list.playId = "PF334482"
        list.genre = "연극"
        list.seat = "S12"
        list.ticket = 66000
        list.poster = ""
        list.title = "닥터지바고"
        list.place = "디큐브시티홀"
        list.runtime = "180분"
        list.time = "19:00"
        let review = UserReview()
        review.text = "고양이가 보고싶다 스트링 리스트에 어떻게 접근하나요 ."
        review.image.append(objectsIn: ["jpg", "jpg"])
        list.userReview.append(review)
        list.userReview.append(review)
        let repository = UserPlayRepository()
        repository.createPlay(list)
        let fetch = repository.fetch()
        print(fetch)
        
        print("Realm:",repository.localRealm.configuration.fileURL!)
        
        let fetchFilter = repository.fetchFilter("율")
        print("###율 검색결과", fetchFilter)
        
        let fetchFilter2 = repository.fetchFilter("에릭")
        print("###에릭 검색결과", fetchFilter2)
        
        let fetchFilter3 = repository.fetchFilter("이호영")
        print("###이호영 검색결과", fetchFilter3)
    }
}

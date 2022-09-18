//
//  KOPISAPIManager.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/18.
//

import Foundation
import Alamofire
import SWXMLHash

class KOPISAPIManager {
    private init() {}
    static let shared = KOPISAPIManager()
    // 공연목록 조회
    func callList(query: String) {
        
        let url = EndPoints.KOPISList
        
        let param: Parameters = [
            "service": APIKeys.KOPIS, // 서비스키
            "shprfnm": query, // 쿼리
            "rows": 100, // 받아오는 개수
            "cpage": 1 // 시작하는 숫자
        ]
        AF.request(url,
                   method: .get,
                   parameters: param).validate().responseData { response in
            switch response.result {
            case .success(let value):
                print(value)
                let xml = XMLHash.parse(value)
                print(xml)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

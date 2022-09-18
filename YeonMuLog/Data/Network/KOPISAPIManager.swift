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
                for elem in xml["dbs"]["db"].all {
                    print(elem["mt20id"].element!.text) // 공연 ID로 상세정보 조회
                    print(elem["genrenm"].element!.text) // 장르
                    print(elem["poster"].element!.text) // 포스터이미지
                    print(elem["openrun"].element!.text) // 오픈런 여부
                    print(elem["fcltynm"].element!.text) // 공연장소
                    print(elem["prfnm"].element!.text) // 극 이름
                    print(elem["prfpdfrom"].element!.text) // 시작날짜
                    print(elem["prfpdto"].element!.text) // 종료날짜
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // 공연 상세 조회
    func callDetail(id: String) {
        let url = EndPoints.KOPISDetail + id
        let param: Parameters = [
            "service": APIKeys.KOPIS // 서비스키
        ]
        AF.request(url,
                   method: .get,
                   parameters: param).validate().responseData { response in
            switch response.result {
            case .success(let value):
                print(value)
                let xml = XMLHash.parse(value)
                print(xml)
                print("--detail--")
                let elem = xml["dbs"]["db"]
                print(elem["prfnm"].element!.text) // 극 이름
                print(elem["prfcast"].element!.text) // 출연진 (난타같은 건 없을수도)
                print(elem["sty"].element!.text) // 줄거리 (거의 없는 것과 마찬가지)
                print(elem["genrenm"].element!.text) // 장르
                print(elem["prfstate"].element!.text) // 공연상태
                print(elem["openrun"].element!.text) // 오픈런(Y/N)
                print(elem["prfpdfrom"].element!.text) // 시작날짜
                print(elem["prfpdto"].element!.text) // 종료날짜
                print(elem["fcltynm"].element!.text) // 공연장소
                print(elem["prfruntime"].element!.text) // 공연런타임
                print(elem["pcseguidance"].element!.text) // 티켓가격
                print(elem["dtguidance"].element!.text) // 공연시간
                print(elem["poster"].element!.text) // 포스터
                print(elem["styurls"].element!.text) // 소개이미지
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

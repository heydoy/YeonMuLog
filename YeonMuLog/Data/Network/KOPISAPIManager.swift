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
    func callList (query: String, completionHandler: @escaping (Result<[Play], Error>) -> Void ) {
        let url = EndPoints.KOPISList
        let param: Parameters = [
            "service": APIKeys.KOPIS, // 서비스키
            "shprfnm": query, // 쿼리
            "rows": 100, // 받아오는 개수
            "cpage": 1 // 시작하는 숫자
        ]
        var playList: [Play] = []
        let group = DispatchGroup()
        
        AF.request(url,
                   method: .get,
                   parameters: param).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let xml = XMLHash.parse(value)
                for elem in xml["dbs"]["db"].all {
                    if let id = elem["mt20id"].element?.text {
                        group.enter()
                        self.callDetail(id: id) { result in
                            switch result {
                            case let .success(result):
                                playList.append(result)
                            case let .failure(error):
                                print(error)
                            }
                            group.leave()
                        }
                    }
                }
                group.notify(queue: .main) {
                    
                    completionHandler(.success(playList))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    // 공연 상세 조회
    func callDetail(id: String, completionHandler: @escaping (Result<Play, Error>) -> Void) {
        let url = EndPoints.KOPISDetail + id
        let param: Parameters = [
            "service": APIKeys.KOPIS // 서비스키
        ]
        AF.request(url,
                   method: .get,
                   parameters: param).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let xml = XMLHash.parse(value)
                let elem = xml["dbs"]["db"]
                let playDetail = Play(
                    id: elem["mt10id"].element!.text,
                    title: elem["prfnm"].element!.text,
                    cast: elem["prfcast"].element!.text,
                    genre: elem["genrenm"].element!.text,
                    poster: elem["poster"].element!.text,
                    place: elem["fcltynm"].element!.text,
                    startDate: elem["prfpdfrom"].element!.text,
                    endDate: elem["prfpdto"].element!.text,
                    runtime: elem["prfruntime"].element!.text,
                    ticket: elem["pcseguidance"].element!.text,
                    time: elem["dtguidance"].element!.text)
                completionHandler(.success(playDetail))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

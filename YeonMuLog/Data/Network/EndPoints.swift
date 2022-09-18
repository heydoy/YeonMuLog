//
//  EndPoints.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/18.
//  - API 문서 : www.kopis.or.kr/upload/openApi/공연예술통합전산망OpenAPI개발가이드.pdf
//

import Foundation

struct EndPoints {
    // KOPIS 
    // 공연 목록 조회
    static let KOPISList =   "http://www.kopis.or.kr/openApi/restful/pblprfr"
    
    // 공연 상세 조회
    static let KOPISDetail = "http://www.kopis.or.kr/openApi/restful/pblprfr/"
    
    // 예매 상황 조회
    static let KOPISBoxOffice = "http://www.kopis.or.kr/openApi/restful/boxoffice"
    
    // 공연별 통계
    static let KOPISStatistics = "http://www.kopis.or.kr/openApi/restful/prfstsPrfBy"
    
    // 수상작 조회
    static let KOPISAwardList = "http://www.kopis.or.kr/openApi/restful/prfawad"
}

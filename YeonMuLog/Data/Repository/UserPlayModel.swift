//
//  UserPlayInfoModel.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/19.
//

import Foundation
import RealmSwift
import UIKit

class UserPlayInfo: Object {
    @Persisted(primaryKey: true) var id: ObjectId // ID값
    @Persisted var playId: String //KOPIS에서 제공할때 쓰는 공연 고유 ID
    @Persisted var title: String // 공연제목
    
    @Persisted var genre: String // 장르
    @Persisted var poster: String // 포스터이미지 웹링크
    @Persisted var place: String // 공연장소
    @Persisted var date: Date // 관람한 공연날짜, 공연시간
    @Persisted var runtime: String // 공연런타임
    @Persisted var seat: String // 자리
    @Persisted var ticket: Int // 티켓종류 가격 (R석 52,000원, S석 44,000원 식. 사용자가 재관할인등 할인을 받을 수 있으므로 일단 저장만 해두고 나중에 디테일하게 가격을 받을 수 있도록 해야되겠다. 입력받을 때는 무조건 Int로 받게끔)
    @Persisted var userReview: List<UserReview> // 사용자 리뷰 모음
    @Persisted var casts: List<String> // 공연캐스트 (Play모델 안에서 ,로 구분해서 사용자에게 보여주고 선택하게 하기)
}

class UserReview: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date
    @Persisted var text: String
    @Persisted var voice: String
    @Persisted var image: List<String> // 도큐먼트에 저장한 이미지 URL
}


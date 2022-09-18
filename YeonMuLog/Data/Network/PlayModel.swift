//
//  PlayModel.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/19.
//

import Foundation

struct Play {
    let id: String // 공연 고유 아이디
    let title: String // 공연제목
    let cast: String // 공연캐스트
    let genre: String // 장르
    let poster: String // 포스터이미지
    let place: String // 공연장소
    let startDate: String // 공연시작날짜
    let endDate: String // 공연종료날짜
    let runtime: String // 공연런타임
    let ticket: String // 티켓종류 가격
    let time: String // 공연시간
}

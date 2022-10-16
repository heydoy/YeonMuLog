//
//  SettingInfo.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/04.
//

import Foundation

public var version: String? {
    guard let dictionary = Bundle.main.infoDictionary,
        let version = dictionary["CFBundleShortVersionString"] as? String,
        let build = dictionary["CFBundleVersion"] as? String else {return nil}
    
    return version
}

struct SettingInfo {
    var text: String?
    var detailText: String?
    var image: String
}

extension SettingInfo {
    static let list: [SettingInfo] = [
        SettingInfo(text: "버전", detailText: version, image: "info.circle"),
        SettingInfo(text: "문의 및 지원", detailText: nil, image: "questionmark.app")
    ]
}

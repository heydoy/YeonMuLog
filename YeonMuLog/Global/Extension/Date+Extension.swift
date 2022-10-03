//
//  Date+Extension.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import Foundation

extension Date {
    func playString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "YYYY.M.d(E) H:mm"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    func reviewDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "YY.M.d H:mm"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    func extractDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "E"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

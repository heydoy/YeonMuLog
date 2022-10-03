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
        dateFormatter.dateFormat = "YYYY.M.d(E) H:m"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

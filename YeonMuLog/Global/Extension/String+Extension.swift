//
//  String+Extension.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/22.
//

import Foundation

extension String {
    // 다국어대응 관련 프로퍼티와 메서드
    var localized: String {
            return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
         return String(format: self.localized, with)
    }

    func localized(number: Int) -> String {
           return String(format: self.localized, number)
    }
}

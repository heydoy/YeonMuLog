//
//  setFonts.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/21.
//

import Foundation
import UIKit

struct AppFont {
    enum appleSDGothicNeo: String {
        case bold = "AppleSDGothicNeo-Bold"
        case semibold = "AppleSDGothicNeo-SemiBold"
        case medium = "AppleSDGothicNeo-Medium"
        case regular = "AppleSDGothicNeo-Regular"
    }
}

enum FontSize: CGFloat {
    case bigTitle = 20
    case title = 17
    case subTitle = 14
    case content = 12
    case caption = 10
}

extension UIFont {
    class func AppleSDGothicNeo(of size: CGFloat, weight: AppFont.appleSDGothicNeo) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }
}

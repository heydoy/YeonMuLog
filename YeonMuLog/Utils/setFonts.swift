//
//  setFonts.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/21.
//

import Foundation
import UIKit

struct AppFont {
    enum AppleSDGothicNeo: String {
        case bold = "AppleSDGothicNeo-Bold"
        case semibold = "AppleSDGothicNeo-SemiBold"
        case medium = "AppleSDGothicNeo-Medium"
        case regular = "AppleSDGothicNeo-Regular"
    }
    
    enum SCoreDream: String {
        case extraLight = "S-CoreDream-2ExtraLight"
        case regular = "S-CoreDream-4Regular"
        case medium = "S-CoreDream-5Medium"
        case extraBold = "S-CoreDream-7ExtraBold"
        case black = "S-CoreDream-9Black"
    }
}

enum FontSize: CGFloat {
    case biggestTitle = 40
    case bigTitle = 20
    case title = 17
    case subTitle = 14
    case content = 12
    case caption = 10
}

extension UIFont {
    class func appleSDGothicNeo(of size: FontSize, weight: AppFont.AppleSDGothicNeo) -> UIFont {
        return UIFont(name: weight.rawValue, size: size.rawValue)!
    }
    
    class func sCoreDream(of size: FontSize, weight: AppFont.SCoreDream) -> UIFont {
        return UIFont(name: weight.rawValue, size: size.rawValue)!
    }
}

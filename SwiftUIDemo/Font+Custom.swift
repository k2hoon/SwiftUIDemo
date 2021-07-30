//
//  Font+Custom.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/31.
//

import Foundation
import SwiftUI

extension Font {
    static func notoSansThin(size: CGFloat) -> Font {
        return Font.custom(FontManager.NotoSans.thin, size: size)
    }
    
    static func notoSansLight(size: CGFloat) -> Font {
        return Font.custom(FontManager.NotoSans.light, size: size)
    }
    
    static func notoSansMedium(size: CGFloat) -> Font {
        return Font.custom(FontManager.NotoSans.medium, size: size)
    }
    
    static func notoSansRegular(size: CGFloat) -> Font {
        return Font.custom(FontManager.NotoSans.regular, size: size)
    }
    
    static func notoSansBold(size: CGFloat) -> Font {
        return Font.custom(FontManager.NotoSans.bold, size: size)
    }
    static func notoSansBlack(size: CGFloat) -> Font {
        return Font.custom(FontManager.NotoSans.black, size: size)
    }
    
    //public static var notoSansBold = FontManager.NotoSans.largeTitle
}

typealias FM = FontManager
struct FontManager {
    
    struct DynamicSize {
        static var largeTitle: CGFloat = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        static var title: CGFloat = UIFont.preferredFont(forTextStyle: .title1).pointSize
    }
    
    // MARK: -
    struct NotoSans {
        private static let family = "NotoSansKR"
        
        // weight
        static let thin = "\(family)-Thin"
        static let light = "\(family)-Light"
        static let medium = "\(family)-Medium"
        static let regular = "\(family)-Regular"
        static let bold = "\(family)-Bold"
        static let black = "\(family)-Black"
        
        // size
        //static let bold: Font = Font.custom(FontManager.NotoSans.boldItem, size: FontManager.DynamicSize.title)
        //static let largeTitle: Font = Font.custom(FontManager.NotoSans.boldItem, size: FontManager.DynamicSize.largeTitle)
        
    }
    
}

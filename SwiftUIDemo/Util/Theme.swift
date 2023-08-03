//
//  Theme.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/08/03.
//

import Foundation
import SwiftUI

class Theme {
    static func tabBarColors(background: UIColor?, blurStyle: UIBlurEffect.Style = .systemMaterial) {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: blurStyle)
        appearance.backgroundColor = background ?? .clear
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    static func navigationBarColors(background: UIColor?, titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}

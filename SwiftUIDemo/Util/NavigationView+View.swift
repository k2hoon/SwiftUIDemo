//
//  NavigationView+View.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/10/17.
//

import Foundation
import SwiftUI

extension View {
    func hiddenNavigationBar() -> some View {
        modifier(HiddenNavigationBar())
    }
}


struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationTitle(Text(""))
            .navigationBarHidden(true)
    }
}

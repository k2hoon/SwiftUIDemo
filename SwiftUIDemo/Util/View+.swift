//
//  View+.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/05.
//

import Foundation
import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func viewSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() { transform(self) }
        else { self }
    }
    
    /// Applies scrollable or not.
    /// - Parameter enabled: the condition to enable
    /// - Returns: Either the original `View` or the modified `View` if the condition is `false`.
    @ViewBuilder func scrollEnabled(_ enabled: Bool) -> some View {
        if enabled { self }
        else { simultaneousGesture(DragGesture(minimumDistance: 0), including: .all) }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

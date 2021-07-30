//
//  Text+ViewModifier.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/31.
//

import Foundation
import SwiftUI

extension View {
    func borderedTextCaption() -> some View {
        modifier(TextBorderedCaption())
    }
}

struct TextBorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .padding(2)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(1)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.blue, lineWidth: 1)
            )
    }
}

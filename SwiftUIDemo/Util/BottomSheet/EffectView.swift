//
//  EffectView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/20.
//

import Foundation
import SwiftUI

struct EffectView: UIViewRepresentable {
    var effect: UIVisualEffect
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: self.effect)
        return effectView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = self.effect
    }
}

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView(effect: UIBlurEffect(style: .regular))
    }
}

//
//  BlurEffectView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/23.
//

import SwiftUI

struct BlurEffectView: View {
    @State var isBlurShow = false
    
    var body: some View {
        VStack {
            Text("Hello, Blur effect!")
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                
            
            Button {
                // action
                self.isBlurShow.toggle()
            } label: {
                Text("Blur effect")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(
            Image("ImageThunderStorm")
                .modifier(BlurEffectModifier(isShow: $isBlurShow))
        )
    }
}

struct BlurEffectView_Previews: PreviewProvider {
    static var previews: some View {
        BlurEffectView()
    }
}

// MARK: - Blur effect view modifier
struct BlurEffectModifier: ViewModifier {
    @Binding var isShow: Bool
    @State var radius: CGFloat = 10
    
    func body(content: Content) -> some View {
        Group {
            content
                .blur(radius: isShow ? radius : 0)
                .animation(.easeOut)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

//
//  AnimatableModifierView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/09.
//

import SwiftUI

struct AnimatableModifierView: View {
    @State private var isDisclosed = false
    @State private var number = 0
    
    var body: some View {
        VStack {
            // title
            Text("Animatable Modifier")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Animation default
            VStack {
                Text("Animation default")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 100, height: 100)
                        .zIndex(1)
                        .onTapGesture {
                            withAnimation { self.isDisclosed.toggle() }
                        }
                    
                    HStack {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 100, height: 100)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .frame(height: isDisclosed ? 200 : 100)
            }
            
            Divider()
            
            // Animation using Animatable Modifier
            VStack {
                Text("Animation using Animatable Modifier")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 100, height: 100)
                        .zIndex(1)
                        .onTapGesture {
                            withAnimation { self.isDisclosed.toggle() }
                        }
                    
                    HStack {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 100, height: 100)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .modifier(AnimatingCellHeight(height: isDisclosed ? 200 : 100))
            }
            
            Divider()
            
            // Number count with Animatable Modifier
            VStack {
                Text("Number count with Animatable Modifier")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(String(number))
                    .modifier(NumberIncrease(number: number))
                
                Button("Increase") {
                    withAnimation(Animation.easeInOut(duration: 2)) {
                        number = 100
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct AnimatableModifierView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableModifierView()
    }
}

extension AnimatableModifierView {
    struct AnimatingCellHeight: AnimatableModifier {
        var height: CGFloat = 0
        
        var animatableData: CGFloat {
            get { height }
            set { height = newValue }
        }
        
        func body(content: Content) -> some View {
            content.frame(height: height)
        }
    }
    
    struct NumberIncrease: AnimatableModifier {
        var number: Int
        
        var animatableData: CGFloat {
            get { CGFloat(number) }
            set { number = Int(newValue) }
        }
        
        func body(content: Content) -> some View {
            Text(String(number))
        }
    }
}


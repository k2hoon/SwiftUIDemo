//
//  ScrollViewTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/01/03.
//

import SwiftUI

struct ScrollViewTestView: View {
    @Namespace var topID
    @Namespace var bottomID
    
    let scrollBounceFixed: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Button("Scroll to Bottom") {
                    withAnimation {
                        proxy.scrollTo(bottomID)
                    }
                }
                .id(topID)
                
                VStack(spacing: 0) {
                    ForEach(0..<100) { index in
                        Button(action: {
                            withAnimation {
                                proxy.scrollTo(index, anchor: .top)
                            }
                        }) {
                            HStack {
                                Text("Scroll to # \(index)")
                                    .padding()
                                Spacer()
                            }
                        }
                        .background(color(fraction: Double(index) / 100))
                        .border(.gray, width: 1)
                        .id(index)
                    }
                }
                
                Button("Top") {
                    withAnimation {
                        proxy.scrollTo(topID)
                    }
                }
                .id(bottomID)
            }
            .onAppear(perform: {
                UIScrollView.appearance().bounces = scrollBounceFixed ? false : true
            })
            .onDisappear(perform: {
                UIScrollView.appearance().bounces = true
            })
        }
    }
    
    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}

struct ScrollViewTestView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewTestView(scrollBounceFixed: true)
    }
}

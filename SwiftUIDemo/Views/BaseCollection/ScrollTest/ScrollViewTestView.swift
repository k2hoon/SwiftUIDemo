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
    
    var scrollBounceFixed: Bool = true
    
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
                
                Button("Scroll to Top") {
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
        Color(red: fraction, green: 1, blue: 1 - fraction)
    }
}

struct ScrollViewTestView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewTestView(scrollBounceFixed: true)
    }
}

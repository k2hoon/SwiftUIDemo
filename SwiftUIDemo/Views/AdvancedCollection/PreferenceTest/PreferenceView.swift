//
//  PreferenceView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/07/01.
//

import SwiftUI

struct PreferenceView: View {
    @State private var offset: CGPoint = .zero
    
    var body: some View {
        VStack {
            Text("Offset: \(String(format: "%.2f", offset.y))")
                .frame(maxWidth: .infinity)
                .padding()
                .background(.gray)
            
            OffsetObservingScrollView(offset: $offset) {
                ForEach(0..<100) { index in
                    Text("number \(index)")
                        .padding()
                }
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}

struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content
    
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(x: -newOffset.x, y: -newOffset.y )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear.preference(
                    key: CGPointPreferenceKey.self,
                    value: geometry.frame(in: coordinateSpace).origin
                )
            })
            .onPreferenceChange(CGPointPreferenceKey.self) { position in
                self.position = position
            }
    }
}

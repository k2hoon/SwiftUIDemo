//
//  BottomSheetTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/23.
//

import SwiftUI

struct BottomSheetTestView: View {
    @State var isBottomSheetShown = false
    
    var body: some View {
        GeometryReader { geometry in
            Color.blue
            
            SampleBottomSheet(isShow: self.$isBottomSheetShown,
                              maxHeight: geometry.size.height * 0.8) {
                Color.gray
            }
        }
        .ignoresSafeArea()
    }
}

struct BottomSheetTestView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetTestView()
    }
}

fileprivate enum Constants {
    static let radius: CGFloat = 18 // edge radius
    
    // indicator properties
    static let indicatorWidth: CGFloat = 60
    static let indicatorHeight: CGFloat = 6
    static let indicatorRadius: CGFloat = 16
    
    static let thresdholdRatio: CGFloat = 0.25 // thread hold ratio
    static let minHeightRatio: CGFloat = 0.3 // minumum sheet height ratio
}

struct SampleBottomSheet<Content: View>: View {
    @Binding var isShow: Bool
    @GestureState private var translation: CGFloat = 0
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    private var offset: CGFloat {
        isShow ? 0 : maxHeight - minHeight
    }
    
    init(isShow: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        
        self._isShow = isShow
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0)) // offset position
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation, body: { value, state, _ in
                    state = value.translation.height
                }).onEnded({ value in
                    let thresdholdDistance = self.maxHeight * Constants.thresdholdRatio
                    guard abs(value.translation.height) > thresdholdDistance else {
                        return
                    }
                    self.isShow = value.translation.height < 0
                })
            )
        }
    }
    
    // indicator
    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.indicatorRadius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
            ).onTapGesture {
                self.isShow.toggle()
            }
    }
}

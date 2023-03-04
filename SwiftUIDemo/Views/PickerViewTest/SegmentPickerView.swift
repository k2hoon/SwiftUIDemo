//
//  SegmentPickerView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/19.
//

import SwiftUI

struct BackgroundGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            return Color.clear
                .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
}

struct SizeAwareViewModifier: ViewModifier {
    @Binding var viewSize: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(BackgroundGeometryReader())
            .onPreferenceChange(SizePreferenceKey.self, perform: {
                if self.viewSize != $0 {
                    self.viewSize = $0
                }
            })
    }
}

struct SegmentItem {
    var title: String
}

struct SegmentPickerView: View {
    private let activeColor = Color(.tertiarySystemBackground)
    //    private let backgroundColor = Color(.secondarySystemBackground)
    private let backgroundColor = Color.clear
    private let shadowColor = Color.black.opacity(0.2)
    private let textColor = Color(.secondaryLabel)
    private let selectedTextColor = Color(.label)
    
    private let textFont = Font.system(size: 12)
    
    private let cornerRadius: CGFloat = 12
    private let shadowRadius: CGFloat = 4
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 8
    private let pickerPadding: CGFloat = 4
    
    private let animationDuration: Double = 0.1
    
    private var activeSegment: AnyView {
        if self.size != .zero {
            // Rounded rectangle is to denote active segment
            return RoundedRectangle(cornerRadius: self.cornerRadius)
                .foregroundColor(self.activeColor)
                .shadow(color: self.shadowColor, radius: self.shadowRadius)
                .frame(width: self.size.width, height: self.size.height)
                .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
                .animation(Animation.linear(duration: self.animationDuration))
                .eraseToAnyView()
        } else {
            return EmptyView().eraseToAnyView()
        }
    }
    
    @State private var size: CGSize = .zero // size of segment, used to create the active segment rect size
    
    //let items: [String]
    let items: [SegmentItem]
    @Binding var selection: Int
    
    var body: some View {
        // align leading edge to make calculating offset on activeSegmentView easier
        ZStack(alignment: .leading) {
            // activeSegment indicates the current selection
            self.activeSegment
            
            HStack {
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.getSegmentButton(at: index)
                }
            }
        }
        .padding(self.pickerPadding)
        .background(self.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius))
    }
    
    // Helper method to compute the offset based on the selected index
    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        CGFloat(self.selection) * (self.size.width + self.horizontalPadding / 2)
    }
    
    // Gets button view for the segment
    private func getSegmentButton(at index: Int) -> some View {
        guard index < self.items.count else {
            return EmptyView().eraseToAnyView()
        }
        
        return Button(action: {
            self.selection = index
        }) {
            Text(self.items[index].title)
                .foregroundColor(self.selection == index ? self.selectedTextColor: self.textColor)
                .lineLimit(1)
                .padding(.vertical, self.verticalPadding)
                .padding(.horizontal, self.horizontalPadding)
                .frame(minWidth: 0, maxWidth: .infinity)
                .modifier(SizeAwareViewModifier(viewSize: self.$size))
        }
        .eraseToAnyView()
    }
    
    // Gets text view for the segment
    private func getSegmentText(at index: Int) -> some View {
        guard index < self.items.count else {
            return EmptyView().eraseToAnyView()
        }
        
        return Text(self.items[index].title)
            .foregroundColor(self.selection == index ? self.selectedTextColor: self.textColor)
            .lineLimit(1)
            .padding(.vertical, self.verticalPadding)
            .padding(.horizontal, self.horizontalPadding)
            .frame(minWidth: 0, maxWidth: .infinity)
            .modifier(SizeAwareViewModifier(viewSize: self.$size))
            .onTapGesture { self.onTapItem(at: index) }
            .eraseToAnyView()
    }
    
    private func onTapItem(at index: Int) {
        guard index < self.items.count else {
            return
        }
        
        self.selection = index
    }
}

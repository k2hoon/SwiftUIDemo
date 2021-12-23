//
//  TabHeaderView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/19.
//

import SwiftUI

struct TabHeader {
    var icon: Image?
    var title: String
}

struct TabHeaderView: View {
    var fixed = true
    var tabs: [TabHeader]
    
    @Binding var selectedTab: Int
    
    var backgroundColor = Color.gray100
    
    var borderColor = Color.blue700
    var borderEgdes: [Edge] = [.top, .bottom]
    var borderWidth: CGFloat = 1.0
    
    var textColor = Color.black
    var textTintColor = Color.gray600
    
    var indicatorColor = Color.cyan700
    
    var body: some View {
        ZStack {
            // Background with border
            self.backgroundColor
                .border(color: self.borderColor, edges: self.borderEgdes, width: self.borderWidth)
            
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 0) {
                            ForEach(0 ..< tabs.count, id: \.self) { row in
                                // header tab button
                                Button(action: {
                                    withAnimation {
                                        selectedTab = row
                                    }
                                }) {
                                    VStack {
                                        Spacer()
                                        
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 13, weight: .medium))
                                            .foregroundColor(selectedTab == row ? self.textColor : self.textTintColor)
                                            .padding(EdgeInsets(top: 9, leading: 0, bottom: 8, trailing: 0))
                                        
                                        // Bar Indicator
                                        Rectangle()
                                            .fill(selectedTab == row ? self.indicatorColor : Color.clear)
                                            .frame(width: fixed ? (geometry.size.width / CGFloat(tabs.count)) : .none, height: 2)
                                            .offset(y: -1)
                                    }
                                }
                                .frame(width: (geometry.size.width / CGFloat(tabs.count)))
                                //.fixedSize()
                                
                            }
                        }
                        .onChange(of: selectedTab) { target in
                            withAnimation {
                                proxy.scrollTo(target)
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
        .onAppear(perform: {
            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            // set bounces past edge of content and back again
            UIScrollView.appearance().bounces = true
        })
    }
}

extension View {
    func border(color: Color, edges: [Edge], width: CGFloat) -> some View {
        overlay(SideBodrer(width: width, edges: edges).foregroundColor(color))
    }
}

struct SideBodrer: Shape {
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading:
                    return rect.minX
                case .trailing:
                    return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing:
                    return rect.minY
                case .bottom:
                    return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom:
                    return rect.width
                case .leading, .trailing:
                    return self.width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom:
                    return self.width
                case .leading, .trailing:
                    return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

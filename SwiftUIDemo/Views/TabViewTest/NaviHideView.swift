//
//  NaviHideView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/13.
//

import SwiftUI

var edges = UIApplication.shared.windows.first?.safeAreaInsets
var rect = UIScreen.main.bounds

struct NaviHideView: View {
    @StateObject var headerData = HeaderViewModel()
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            //        VStack {
            HeaderView(viewModel: headerData)
            //                .frame(height: 60)
                .zIndex(1)
                .offset(y: headerData.headerOffset)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(1...5, id: \.self) { index in
                        Image("imagePost\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width - 30, height: 250, alignment: .center)
                            .cornerRadius(1)
                        
                        HStack(spacing: 10) {
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35, alignment: .center)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("New world")
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                
                                Text("hello world")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                    }
                }
                .padding(.top, 75)
                .overlay(alignment: .top) {
                    GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        DispatchQueue.main.async {
                            headerData.minY = minY
                            headerData.maxOffset = getMaxOffset()
                            if headerData.startMinY == 0 {
                                headerData.startMinY = minY
                            }
                            
                            // init
                            // startMinY 59
                            // minY 59--
                            let offset = headerData.startMinY - minY
                            
                            if offset > headerData.offset { // top
                                headerData.bottomScrollOffset = 0
                                
                                if headerData.topScrollOffset == 0 {
                                    headerData.topScrollOffset = offset
                                }
                                
                                // 초기 값은 거읜 getMaxOffset(128) 언저리 지만 offset이 증가하면서 progress는 0이 된다.
                                let progress = (headerData.topScrollOffset + getMaxOffset()) - offset
                                headerData.progress = progress
                                
                                let offsetCondition = (headerData.topScrollOffset + getMaxOffset()) >= getMaxOffset() && getMaxOffset() - progress <= getMaxOffset()
                                
                                // offsetCondition가 true면 getMaxOffset(128)에서 점점 감소하는 progress값을 뺀다.
                                // false면 더 이상 headerOffset getMaxOffset(128)로 고정된다.
                                let headerOffset = offsetCondition ? -(getMaxOffset() - progress) : -getMaxOffset()
                                headerData.headerOffset = headerOffset
                            }
                            
                            if offset < headerData.offset { // bottom
                                headerData.topScrollOffset = 0
                                if headerData.bottomScrollOffset == 0 {
                                    headerData.bottomScrollOffset = offset
                                }
                                
                                withAnimation(.easeOut(duration: 0.25)) {
                                    let headerOffset = headerData.headerOffset
                                    headerData.headerOffset = headerData.bottomScrollOffset > offset + 40 ? 0 : (headerOffset != -getMaxOffset() ? 0 : headerOffset)
                                }
                            }
                            
                            headerData.offset = offset
                            
                        }
                        
                        return Color.clear
                    }
                    .frame(height: 1)
                }
            }
            
        }
    }
    
    func getMaxOffset() -> CGFloat {
        // top edge 59
        return headerData.startMinY + (edges?.top ?? 0) + 10
    }
}

extension NaviHideView {
    class HeaderViewModel: ObservableObject {
        @Published var minY: CGFloat = 0
        @Published var startMinY: CGFloat = 0
        @Published var offset: CGFloat = 0
        @Published var headerOffset: CGFloat = 0
        @Published var topScrollOffset: CGFloat = 0
        @Published var bottomScrollOffset: CGFloat = 0
        
        @Published var offsetCondition: CGFloat = 0
        @Published var progress: CGFloat = 0
        @Published var maxOffset: CGFloat = 0
    }
    
    struct HeaderView: View {
        @ObservedObject var viewModel: HeaderViewModel
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("minY: \(viewModel.minY)")
                Text("startMinY: \(viewModel.startMinY)")
                Text("offset: \(viewModel.offset)")
                Text("topScrollOffset: \(viewModel.topScrollOffset)")
                Text("bottomScrollOffset: \(viewModel.bottomScrollOffset)")
                Text("maxOffset: \(viewModel.maxOffset)")
                Text("progress: \(viewModel.progress)")
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white.ignoresSafeArea(.all, edges: .top))
            .overlay(alignment: .bottom) {
                Divider()
            }
            
            //            HStack(spacing: 20) {
            //                Image(systemName: "youtube")
            //                    .resizable()
            //                    .aspectRatio(contentMode: .fit)
            //                    .frame(width: 40, height: 40, alignment: .center)
            //
            //                Text("YouTube")
            //                    .font(.title3)
            //                    .fontWeight(.bold)
            //                    .foregroundColor(.primary)
            //                    .kerning(0.5) //word spacing
            //                    .offset(x: -10)
            //
            //                Spacer(minLength: 0)
            //
            //                Button(action: {}) {
            //                    Image(systemName: "display")
            //                        .font(.title2)
            //                        .foregroundColor(.primary)
            //                }
            //
            //                Button(action: {}) {
            //                    Image(systemName: "bell")
            //                        .font(.title2)
            //                        .foregroundColor(.primary)
            //                }
            //
            //                Button(action: {}) {
            //                    Image(systemName: "magnifyingglass")
            //                        .font(.title2)
            //                        .foregroundColor(.primary)
            //                }
            //
            //                Button(action: {}) {
            //                    Image(systemName: "person")
            //                        .resizable()
            //                        .aspectRatio(contentMode: .fill)
            //                        .frame(width: 30, height: 30, alignment: .center)
            //                        .clipShape(Circle())
            //                }
            //            }
            //            .padding(.horizontal)
            //            .padding(.vertical, 8)
            //            .background(Color.white.ignoresSafeArea(.all, edges: .top))
            //            .overlay(alignment: .bottom) {
            //                Divider()
            //            }
        }
    }
}

struct NaviHideView_Previews: PreviewProvider {
    static var previews: some View {
        NaviHideView()
    }
}

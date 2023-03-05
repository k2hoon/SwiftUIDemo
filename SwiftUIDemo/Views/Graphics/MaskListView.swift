//
//  MaskListView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/06.
//

import SwiftUI

struct MaskListView: View {
    var body: some View {
        VStack {
            Text("Masks list item")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            VStack {
                Text("horizontal list")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HorizontalList()
            }
            
            Divider()
            
            VStack {
                Text("vertical list")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    ListFadeView()
                    
                    ListBlurView()
                }
            }
            
        }
        .padding()
    }
}

struct MaskListView_Previews: PreviewProvider {
    static var previews: some View {
        MaskListView()
    }
}

// MARK: Masks Horizontal List
extension MaskListView {
    struct HorizontalList: View {
        var body: some View {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<10) { idx in
                        Button(action: {}) {
                            Text("\(idx) Row")
                                .padding()
                                .foregroundColor(.black)
                                .background(.blue)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding() // padding hstack
            }
            .frame(height: 80)
            .safeAreaInset(edge: .trailing) {
                Button { } label: {
                    Text("Button")
                        .foregroundColor(.black)
                        .padding()
                        .background(.gray)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .background {
                    Color(uiColor: .systemBackground)
                        .mask(alignment: .top) {
                            HStack(spacing: 0) {
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .clear, location: .zero),
                                        Gradient.Stop(color: .black, location: 1.0)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                
                                Color.black
                            }
                        }
                        .padding(.vertical, -32)
                }
            }
        }
    }
}


// MARK: Masks Vertical List
extension MaskListView {
    struct ListFadeView: View {
        var body: some View {
            ScrollView {
                ForEach(1..<30) { idx in
                    Text("text \(idx)")
                }
                .frame(maxWidth: .infinity)
            }
            .safeAreaInset(edge: .bottom) {
                Button { } label: {
                    Text("Button")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal)
                .background {
                    Color(uiColor: .systemBackground)
                        .background(.ultraThickMaterial)
                        .mask(alignment: .top) {
                            VStack(spacing: 0) {
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .clear, location: .zero),
                                        Gradient.Stop(color: .black, location: 1.0)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 32)
                                Color.black
                            }
                        }
                        .padding(.top, -32)
                        .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
    }
    
    struct ListBlurView: View {
        var body: some View {
            List(1..<30, id: \.self) { idx in
                Text("text \(idx)")
            }
            .listStyle(.plain)
            .safeAreaInset(edge: .bottom) {
                Button { } label: {
                    Text("Button")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal)
                .background {
                    Color.clear
                        .background(.ultraThickMaterial)
                        .mask(alignment: .top) {
                            VStack(spacing: 0) {
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .clear, location: .zero),
                                        Gradient.Stop(color: .black, location: 1.0)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 32)
                                Color.black
                            }
                        }
                        .padding(.top, -32)
                        .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
    }
}

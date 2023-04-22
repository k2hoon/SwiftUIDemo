//
//  ViewBuilderTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/01/10.
//

import SwiftUI

struct ViewBuilderTestView: View {
    var body: some View {
        ViewBuilderTester(header: {
            VStack {
                Text("Header")
                    .font(.title)
                Text("Header subtitle")
                    .font(.caption)
            }
            .background(Color.blue700)
            
        })
        
        //        ViewBuilerTester(
        //            header: {
        //                VStack {
        //                    Text("Header")
        //                        .font(.title)
        //                    Text("Header subtitle")
        //                        .font(.caption)
        //                }
        //                .background(Color.blue700)
        //            },
        //            content: {
        //                Image(systemName: "star.fill")
        //                    .resizable()
        //                    .aspectRatio(contentMode: .fit)
        //                    .frame(width: 100, height: 100)
        //                    .background(Color.gray600)
        //            })
    }
}

struct ViewBuilderTestView_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderTestView()
    }
}

// MARK: - ViewBuilder tester view
extension ViewBuilderTester where Content == EmptyView {
    init(header: () -> Header) {
        self.init(header: header, content: { EmptyView() })
    }
}

struct ViewBuilderTester<Header: View, Content: View>: View {
    private let header: Header
    private let content: Content
    
    init(@ViewBuilder header: () -> Header,
         @ViewBuilder content: () -> Content) {
        self.header = header()
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                header
                Spacer()
                content
                Spacer()
            }
        }
    }
}



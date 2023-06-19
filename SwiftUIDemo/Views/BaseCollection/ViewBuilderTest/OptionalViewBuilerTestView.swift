//
//  OptionalViewBuilerTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/01/11.
//

import SwiftUI

struct OptionalViewBuilerTestView: View {
    var body: some View {
        OptionalViewBuilerTester(header: {
            VStack {
                Text("Header")
                    .font(.title)
                Text("Header subtitle")
                    .font(.caption)
            }
            .background(Color.blue700)
        })
    }
}

struct OptionalViewBuilerTestView_Previews: PreviewProvider {
    static var previews: some View {
        OptionalViewBuilerTestView()
    }
}

// MARK: - Optional view builder tester view
struct OptionalViewBuilerTester<Content: View>: View {
    private let header: () -> Content
    private let content: () -> Content?
    
    init(@ViewBuilder header: @escaping () -> Content,
         @ViewBuilder content: @escaping () -> Content? = { nil }) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                header()
                Spacer()
                content()
                Spacer()
            }
        }
    }
}


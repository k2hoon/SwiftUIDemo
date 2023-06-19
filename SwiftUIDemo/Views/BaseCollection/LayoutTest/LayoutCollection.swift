//
//  LayoutCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct LayoutCollection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Layout")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 22) {
                    ForEach(ViewType.allCases, id: \.self) { view in
                        NavigationLink(destination: { view.viewBuilder() }) {
                            Text(view.rawValue)
                                .font(.callout)
                                .padding()
                                .frame(width: 150, height: 150)
                                .background(.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.25), radius: 6, x: 4, y: 4)
                        }
                    }
                }
                .padding()
            }
            
            Divider()
        }
    }
}

struct LayoutCollection_Previews: PreviewProvider {
    static var previews: some View {
        LayoutCollection()
    }
}

extension LayoutCollection {
    enum ViewType: String, CaseIterable {
        case `default` = "SafeArea test"
        case inset = "SafeAreaInset test"
        case vstack = "SafeArea VStack"
        case keyboard = "SafeArea with keyboard"
        case layout = "Layout test"
        
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .default: SafeAreaView()
            case .inset: SafeAreaInsetView()
            case .vstack: SafeAreaView_VStack()
            case .keyboard: SafeAreaView_Keyboard()
            case .layout: LayoutTestView()
            }
        }
    }
}

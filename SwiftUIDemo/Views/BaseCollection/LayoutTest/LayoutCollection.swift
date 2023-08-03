//
//  LayoutCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct LayoutCollection: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ViewType.allCases, id: \.self) { view in
                    NavigationLink(view.rawValue) {
                        view.viewBuilder()
                    }
                }
            }
            .navigationTitle("Layout Test")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { self.dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
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

//
//  NavigationCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/06/19.
//

import SwiftUI

struct NavigationCollection: View {
    @Environment(\.dismiss) var dismiss
    
    @State var selection: ViewType? = nil
    @State var present = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ViewType.allCases, id: \.self) { view in
                    NavigationLink(view.rawValue) {
                        view.viewBuilder()
                    }
                }
            }
            .navigationTitle("Navigation Test")
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

struct NavigationCollection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationCollection()
    }
}

extension NavigationCollection {
    enum ViewType: String, CaseIterable {
        case `default` = "Navigation view"
        case link = "Navigation link"
        case hidden = "Navigation hide"
        case toolbar = "Navigation tool bar"
        case tabbar = "Navigation tab"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .default: NavigationTestView()
            case .link: NavigationLinkTestView()
            case .hidden: NavigationHiddenView()
            case .toolbar: NavigationToolbarView()
            case .tabbar: NavigationTabView()
            }
        }
    }
}

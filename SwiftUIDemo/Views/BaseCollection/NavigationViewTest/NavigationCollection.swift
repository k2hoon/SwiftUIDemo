//
//  NavigationCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/06/19.
//

import SwiftUI

struct NavigationCollection: View {
    @State var selection: ViewType? = nil
    @State var present = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Navigation")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 22) {
                    ForEach(ViewType.allCases, id: \.self) { view in
                        Button(action: { self.selection = view }) {
                            Text(view.rawValue)
                                .font(.callout)
                                .padding()
                                .frame(width: 150, height: 150)
                                .background(.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.25), radius: 6, x: 4, y: 4)
                        }
                        .sheet(isPresented: $present) {
                            self.selection?.viewBuilder()
                        }
                    }
                }
                .padding()
            }
            .onChange(of: self.selection) { newValue in
                self.present.toggle()
            }
            
            Divider()
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

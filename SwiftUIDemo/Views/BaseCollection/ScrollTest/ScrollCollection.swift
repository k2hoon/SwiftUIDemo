//
//  ScrollCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/06/19.
//

import SwiftUI

struct ScrollCollection: View {
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
            .navigationTitle("Scroll Test")
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

struct ScrollCollection_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCollection()
    }
}

extension ScrollCollection {
    enum ViewType: String, CaseIterable {
        case `default` = "ScrollView test"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .default: ScrollViewTestView()
            }
        }
    }
}

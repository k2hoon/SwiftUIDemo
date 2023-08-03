//
//  BasicView+Font.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct FontCollection: View {
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
            .navigationTitle("Font Test")
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

struct FontCollection_Previews: PreviewProvider {
    static var previews: some View {
        FontCollection()
    }
}

extension FontCollection {
    enum ViewType: String, CaseIterable {
        case test = "Font test"
        case weight = "Font weight"
        case design = "Font design"
        case style = "Font style"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .test: FontTestView()
            case .weight: FontWeightView()
            case .design: FontDesignView()
            case .style: FontTextStyle()
            }
        }
    }
}

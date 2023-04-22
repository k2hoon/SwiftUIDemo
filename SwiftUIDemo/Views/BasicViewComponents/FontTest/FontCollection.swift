//
//  BasicView+Font.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct FontCollection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Font")
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

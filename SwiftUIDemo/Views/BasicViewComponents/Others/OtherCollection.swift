//
//  OtherCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct OtherCollection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Other")
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

struct OtherCollection_Previews: PreviewProvider {
    static var previews: some View {
        OtherCollection()
    }
}

extension OtherCollection {
    enum ViewType: String, CaseIterable {
        case weblink = "Weblink test"
        case json = "Json test"
        case date = "Date format test"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .weblink: WebLinkTestView()
            case .json: JsonView()
            case .date: DateFormatterView()
            }
        }
    }
}

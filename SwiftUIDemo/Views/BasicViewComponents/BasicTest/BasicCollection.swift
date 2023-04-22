//
//  BasicCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct BasicCollection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Basic")
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

struct BasicCollection_Previews: PreviewProvider {
    static var previews: some View {
        BasicCollection()
    }
}

// MARK: BasicCollection
extension BasicCollection {
    enum ViewType: String, CaseIterable {
        case button = "Button test"
        case text = "Text test"
        case textField = "TextField test"
        case viewbuilder = "ViewBuiler test"
        case geometry = "GeometryReader test"
        
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .button: ButtonTestView()
            case .text: TextTestView()
            case .textField: TextFieldTestView()
            case .viewbuilder: ViewBuilderTestView()
            case .geometry: GeometryReaderTestView()
            }
        }
    }
}

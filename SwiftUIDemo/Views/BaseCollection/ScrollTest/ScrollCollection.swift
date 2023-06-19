//
//  ScrollCollection.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/06/19.
//

import SwiftUI

struct ScrollCollection: View {
    @State var selection: ViewType? = nil
    @State var present = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Scroll")
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

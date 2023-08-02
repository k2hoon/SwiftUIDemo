//
//  TestingView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/23.
//

import SwiftUI

struct CoreDataView: View {
    var body: some View {
        VStack {
            Text("Thia is designed to provide a collection of core data.")
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            List {
                ForEach(ViewType.allCases, id: \.self) { view in
                    NavigationLink(view.rawValue) {
                        view.viewBuilder()
                    }
                }
            }
        }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataView()
    }
}


extension CoreDataView {
    enum ViewType: String, CaseIterable {
        case coreData = "Core Data test"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .coreData: CoreDataTestView()
            }
        }
    }
}

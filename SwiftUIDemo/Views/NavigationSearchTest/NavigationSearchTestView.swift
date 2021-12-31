//
//  NavigationSearchTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/23.
//

import SwiftUI

struct NavigationSearchTestView: View {
    @State private var searchText: String = ""
    @State private var isSearching = false
    
    let sampleData: [String] = ["Apple","Avocado","Banana","Blackberry",
                                "Cherry","Coconut","Dragonfruit","Grapefruit",
                                "Kiwifruit","Lemon","Lime","Mango",
                                "Melon", "Nectarine", "Orange", "Papaya",
                                "Peach", "Pear", "Pineapple", "Raspberry", "Tomato"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sampleData.filter {
                    self.searchText.isEmpty ? true : $0.contains(self.searchText)
                }, id: \.self) { fruit in
                    Text(fruit)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .modifier(HiddenNavigationToolBar(isSearching: $isSearching))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationSearchTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSearchTestView()
    }
}

struct HiddenNavigationToolBar: ViewModifier {
    @Binding var isSearching: Bool
    func body(content: Content) -> some View {
        if self.isSearching {
            content
            // TODO: using searchable here.
        } else {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("hello")
                            .font(.title)
                            .bold()
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button("Search") {
                            print("Search tapped!")
                            self.isSearching = true
                        }
                        
                        Button("About") {
                            print("About tapped!")
                        }
                        
                        Button("Help") {
                            print("Help tapped!")
                        }
                    }
                }
        }
    }
}

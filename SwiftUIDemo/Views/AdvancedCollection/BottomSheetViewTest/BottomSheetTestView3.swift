//
//  BottomSheetTestView2.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/20.
//

import SwiftUI

struct BottomSheetTestView3: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var searchText: String = ""
    
    let backgroundColors: [Color] = [Color(red: 0.28, green: 0.28, blue: 0.21), Color(red: 0.25, green: 0.2, blue: 1)]
    let words: [String] = ["Hello", "world", "expose", "hide",
                           "brilliant", "brush", "coke",
                           "cat", "home", "pin",
                           "bolt", "red", "celebrate",
                           "known", "year", "zoo"]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: self.backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition,
                         options: [.appleScrollBehavior,
                                   .backgroundBlur(effect: .dark)],
                         header: {
                
                // SearchBar as headerContent.
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: self.$searchText)
                }
                .foregroundColor(Color(UIColor.secondaryLabel))
                .padding(.vertical, 8)
                .padding(.horizontal, 5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternaryLabel)))
                .padding(.bottom)
                .onTapGesture {
                    // when tap the SearchBar, the BottomSheet moves to the .top position.
                    self.bottomSheetPosition = .top
                }
            }, content: {
                ForEach(self.words.filter({ $0.contains(self.searchText.lowercased()) || self.searchText.isEmpty }),
                        id: \.self) { word in
                    Text(word)
                        .font(.title)
                        .padding([.leading, .bottom])
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.opacity)
                        .animation(.easeInOut)
                        .padding(.top)
            })
    }
}

struct BottomSheetTestView3_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetTestView3()
    }
}

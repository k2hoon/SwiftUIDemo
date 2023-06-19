//
//  BottomSheetTestView1.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/20.
//

import SwiftUI

struct BottomSheetTestView2: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    let backgroundColors: [Color] = [Color(red: 0.17, green: 0.17, blue: 0.33), Color(red: 0.80, green: 0.38, blue: 0.2)]
    let fruits: [String] = ["Apple(red) 🍎",
                            "Apple(green) 🍏",
                            "Tomato 🍅",
                            "Grape 🍇",
                            "Cherry 🍒",
                            "Melon 🍈",
                            "Blueberry 🫐",
                            "Kiwi 🥝",
    ]
    
    var body: some View {
        Color.gray
            .ignoresSafeArea()
            .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition,
                         options: [.animation(.linear.speed(0.4)),
                                   .dragIndicatorColor(Color(red: 0.17, green: 0.17, blue: 0.33)),
                                   .background(AnyView(Color.white)),
                                   .noBottomPosition,
                                   .cornerRadius(30),
                                   .shadow(color: .black)],
                         title: "Hello world!") {
                //list of the most popular songs of the artist.
                List {
                    ForEach(self.fruits, id: \.self) { fruit in
                        Text(fruit)
                    }
                }
            }
    }
}

struct BottomSheetTestView2_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetTestView2()
    }
}

//
//  BottomSheetTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/20.
//

import SwiftUI

//The custom BottomSheetPosition enum.
enum BookBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.5
    case bottom = 0.125
    case hidden = 0
}

//The gradient ButtonStyle.
struct BookButton: ButtonStyle {
    let colors: [Color]
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct BottomSheetTestView1: View {
    @State var sheetPosition: BookBottomSheetPosition = .middle
    
    let findMoreColors: [Color] = [Color(red: 0.22, green: 0.22, blue: 0.72), Color(red: 0.32, green: 0.32, blue: 1)]
    let bookmarkColors: [Color] = [Color(red: 0.28, green: 0.53, blue: 0.53), Color(red: 0.44, green: 0.83, blue: 0.83)]
    
    var body: some View {
        Color.gray
            .ignoresSafeArea()
            .bottomSheet(bottomSheetPosition: self.$sheetPosition,
                         options: [.allowContentDrag,
                                   .showCloseButton(),
                                   .swipeToDismiss,
                                   .tapToDissmiss],
                         header: {
                VStack(alignment: .leading) {
                    Text("Lorem Ipsum")
                        .font(.title)
                        .bold()
                    
                    Text("from De finibus bonorum et malorum")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                        .padding(.trailing, -30)
                }
            }, content: {
                VStack(spacing: 0) {
                    Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // Buttons
                    HStack {
                        Button(action: {}) {
                            Text("Find More")
                                .padding(.horizontal)
                        }
                        .buttonStyle(BookButton(colors: self.findMoreColors))
                        .clipShape(Capsule())
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                        }
                        .buttonStyle(BookButton(colors: self.bookmarkColors))
                        .clipShape(Circle())
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal, .top])
            })
    }
}

struct BottomSheetTestView1_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetTestView1()
    }
}

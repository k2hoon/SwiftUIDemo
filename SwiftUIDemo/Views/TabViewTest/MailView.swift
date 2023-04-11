//
//  MailView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/12.
//

import SwiftUI

struct MailView: View {
    struct Message: Hashable {
        var userName: String
        var message: String
        var tintColor: Color
    }
    
    @Binding var hideTab: Bool
    var bottomEdge: CGFloat
    var messages: [Message] = (0...20).map {
        Message(userName: "\($0)", message: "Sample message \($0)", tintColor: .green300)
    }
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("PRIMARY")
                    .font(.callout.bold())
                    .foregroundColor(.gray)
                    .padding(.leading, 5)
                
                ForEach(messages, id: \.self) { message in
                    CarView(message: message)
                }
            }
            // GeometryReader for calculating offset
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    let durationOffset: CGFloat = 35
                    DispatchQueue.main.async {
                        if minY < offset { // up
                            if offset < 0 && -minY > (lastOffset + durationOffset) {
                                withAnimation(.easeOut.speed(1.5)) {
                                    hideTab = true
                                }
                                lastOffset = -offset
                            }
                        }
                        
                        if minY > offset && -minY < (lastOffset - durationOffset) { // down
                            withAnimation(.easeOut.speed(1.5)) {
                                hideTab = false
                            }
                            lastOffset = -offset
                        }
                        self.offset = minY
                    }
                    return Color.clear
                }
            )
            .padding()
            .padding(.bottom, 15 + bottomEdge + 35)
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func CarView(message: Message) -> some View {
        HStack(spacing: 15) {
            Text(String(message.userName.first ?? "i"))
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 55, height: 55)
                .background(message.tintColor, in: Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(message.userName)
                    .fontWeight(.bold)
                Text(message.message)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarHideHome()
    }
}

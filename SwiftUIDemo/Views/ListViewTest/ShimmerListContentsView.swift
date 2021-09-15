//
//  ShimmerListContentsView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI

struct ShimmerListContentsView: View {
    @Environment(\.redactionReasons) private var redactionReasons
    let items: [UserInfoItem]
    private var isRedacted: Bool {
        redactionReasons.contains(.placeholder)
    }
    
    var body: some View {
        List(items) { item in
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: item.systemName)
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.title)
                    Text(item.description)
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .animation(.none)
    }
}

struct ShimmerListContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerListContentsView(items: [
            UserInfoItem(id: 0,
                         username: "hello, world",
                         title: "title",
                         description: "subtitle",
                         systemName: "list.bullet")
        ])
    }
}

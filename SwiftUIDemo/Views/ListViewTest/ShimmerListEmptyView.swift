//
//  ShimmerListEmptyView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI

struct ShimmerListEmptyView: View {
    let message: String
    let systemName: String
    
    init(message: String, image systemName: String) {
        self.message = message
        self.systemName = systemName
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: systemName).font(.system(size: 48))
            Text(message)
            Spacer()
        }
    }
}

struct ShimmerListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerListEmptyView(message: "message", image: "exclamationmark.bubble.fill")
    }
}

//
//  TitleViewComponents.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/10.
//

import Foundation
import SwiftUI

struct TitleBack: View {
    var title: String
    var spacing: CGFloat
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Button(action: { self.action() }) {
                Label(
                    title: { Text("Back") },
                    icon: { Image(systemName: "chevron.left") }
                )
                .foregroundColor(.primary)
            }
            
            Text(self.title)
                .font(.title)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TitlePerson: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(self.title)
                .font(.title)
            
            Spacer(minLength: 10)
            
            Button(action: {}) {
                Image(systemName: "person.circle")
                    .font(.title)
                    .foregroundColor(.gray)
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(.red)
                            .frame(width: 10, height: 10)
                            .offset(x: -1, y: -1)
                    }
            }
        }
    }
}

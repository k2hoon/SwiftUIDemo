//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/03/15.
//

import SwiftUI


struct ContentView: View {
    @State private var isWebLinkTestActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello. This is...")
                    .font(.headline)
                    .padding()
                HStack {
                    Text("""
                    This is somethig to explain....
                    """)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                NavigationLink(
                    destination: WebLinkTestView(),
                    isActive: $isWebLinkTestActive,
                    label: {
                        Button(action: {
                            self.isWebLinkTestActive.toggle()
                        }, label: {
                            Text("WebLinkTestView")
                        })
                        
                    })
            }
        }
        .navigationTitle("")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

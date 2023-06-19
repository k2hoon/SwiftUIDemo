//
//  MaterialView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/06.
//

import SwiftUI

struct MaterialView: View {
    var body: some View {
        ZStack {
            Color.mint
            VStack(alignment: .leading) {
                HStack {
                    Label("Bolt", systemImage: "bolt.fill")
                        .padding()
                        .background(.thinMaterial)
                    Text("thinMaterial")
                }
                
                HStack {
                    Label("Bolt", systemImage: "bolt.fill")
                        .padding()
                        .background(.thickMaterial)
                    Text("thickMaterial")
                }
                
                HStack {
                    Label("Bolt", systemImage: "bolt.fill")
                        .padding()
                        .background(.regularMaterial)
                    Text("regularMaterial")
                }
                
                HStack {
                    Label("Bolt", systemImage: "bolt.fill")
                        .padding()
                        .background(.ultraThickMaterial)
                    Text("ultraThickMaterial")
                }
                
                HStack {
                    Label("Bolt", systemImage: "bolt.fill")
                        .padding()
                        .background(.ultraThinMaterial)
                    Text("ultraThinMaterial")
                }
            }
        }
        
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView()
    }
}


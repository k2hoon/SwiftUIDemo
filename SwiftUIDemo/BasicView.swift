//
//  BasicView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct BasicView: View {
    var body: some View {
        VStack {
            ScrollView {
                BasicCollection()
                
                FontCollection()
                
                LayoutCollection()
                
                OtherCollection()
            }
        }
    }
}

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BasicView()
        }
    }
}

//
//  BaseView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct BaseView: View {
    
    var body: some View {
        VStack {
            ScrollView {
                BasicCollection()
                
                FontCollection()
                
                LayoutCollection()
                
                NavigationCollection()
                
                ScrollCollection()
                
                OtherCollection()
            }
        }
    }
}

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BaseView()
        }
    }
}

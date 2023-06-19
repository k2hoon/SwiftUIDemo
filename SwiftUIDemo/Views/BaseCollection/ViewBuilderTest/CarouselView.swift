//
//  CarouselView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/01/11.
//

import SwiftUI

struct CarouselView<Content: View>: ContainerView {
    var content: () -> Content
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(content: content)
                .padding()
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView {
            Text("Item 1")
                .font(.title)
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.blue700)
            Text("Item 2")
                .font(.title)
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.blue700)
            Text("Item 3")
                .font(.title)
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.blue700)
            Text("Item 4")
                .font(.title)
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.blue700)
        }
    }
}

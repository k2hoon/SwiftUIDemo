//
//  PinchZoomTest.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/12/26.
//

import SwiftUI

struct PinchZoomTestView: View {
    var body: some View {
        ZStack {
            PinchView(imagename: "night-city")
                .ignoresSafeArea()
        }
    }
}

struct PinchZoomTest_Previews: PreviewProvider {
    static var previews: some View {
        PinchZoomTestView()
    }
}

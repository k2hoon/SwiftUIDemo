//
//  GeometryReaderTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import SwiftUI

struct GeometryReaderTestView: View {
    @AppStorage("samplestring") var sampleString = "hello"
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text("Left")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.33)
                    .background(Color.yellow)
                Text("Right")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.67)
                    .background(Color.orange)
            }
        }
        .frame(height: 50)
        //            Text("AppStorage key value is \(sampleString)")
        //                .padding()
        //            Button(action: {
        //                sampleString = "hello, world!"
        //            }, label: {
        //                Text("Button")
        //            })
    }
}

struct GeometryReaderTestView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderTestView()
    }
}

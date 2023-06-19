//
//  LayoutTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/02/21.
//

import SwiftUI

struct LayoutTestView: View {
    var body: some View {
        // default spacing is '8'
        VStack {
            // Value of type 'some View' has no member 'fill'
            Text("asdf")
                .frame(width: 100, height: 100, alignment: .center)
                .border(.blue)
            
            // default padding value is '16'
            Circle()
                .border(.red)
                .padding()
                .border(.red)
                
            Circle()
                .fill(Color(hex: "#A9A9A9"))
                .shadow(color: .black.opacity(0.0), radius: 2, x: 0, y: 0)
                .padding(16)
                .frame(width: 100, height: 100, alignment: .center)
                .border(.blue)
            
            Circle()
                .fill(Color(hex: "#3E454F"))
                .shadow(color: .black.opacity(1), radius: 2, x: 0, y: 0)
                .padding(16)
                .frame(width: 100, height: 100, alignment: .center)
                .border(.blue)
            
            Circle()
                .fill(Color(.sRGBLinear, red: 255, green: 65, blue: 65, opacity: 1))
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 0)
                .padding(0)
                .frame(width: 100, height: 100, alignment: .center)
                .border(.blue)

            Circle()
                .fill(.red)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 0)
                .frame(width: 100, height: 100, alignment: .center)
                .border(.blue)
                .padding()
                .border(.blue)
                .padding()
                .border(.blue)
        }
    }
}

struct LayoutTestView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutTestView()
    }
}

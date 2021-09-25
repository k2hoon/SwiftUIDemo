//
//  GeometryReaderTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import SwiftUI

struct GeometryReaderTestView: View {
    var body: some View {
        GeometryReader { geometry in
            Text("Center")
                .frame(width: 100, height: 100, alignment: .center)
                .border(.blue, width: 2)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(width: 400, height: 400, alignment: .center)
        .border(.red, width: 2)
//        VStack {
//            Rectangle()
//                .foregroundColor(.black)
//
//            GeometryReaderContentView()
//        }
    }
}

struct GeometryReaderTestView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderTestView()
    }
}

// MARK: - GeometryReader ContentView
struct GeometryReaderContentView: View {
    @State var isTopTapped = false
    @State var isBottomTapped = false
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("Top")
                    .font(.title)
                    .frame(width: isTopTapped ? geometry.size.width : geometry.size.width / 2,
                           height: geometry.size.height / 4,
                           alignment: .center)
                    .background(Color.gray)
                    .onTapGesture {
                        withAnimation {
                            self.isTopTapped.toggle()
                        }
                    }
                
                HStack(spacing: 0) {
                    Text("Left (1/3)")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(width: geometry.size.width * 0.33, height: (geometry.size.height / 4), alignment: .center)
                        .background(Color.blue)
                    
                    Text("Right (2/3)")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(width: geometry.size.width * 0.67, height: (geometry.size.height / 4), alignment: .center)
                        .background(Color.green)
                }
                
                Text("Bottom")
                    .font(.title)
                    .frame(width: geometry.size.width / 2,
                           height: isBottomTapped ? geometry.size.height / 2 : geometry.size.height / 4,
                           alignment: .center)
                    .background(Color.gray)
                    .onTapGesture {
                        withAnimation {
                            self.isBottomTapped.toggle()
                        }
                    }
            }
        }
        .border(.red, width: 4)
    }
}

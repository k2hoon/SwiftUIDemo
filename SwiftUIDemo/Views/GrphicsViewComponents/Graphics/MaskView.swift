//
//  MaskView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/05.
//

import SwiftUI

struct MaskView: View {
    private let alignments: [Alignment] = [
        .center, .leading, .trailing,
        .top, .bottom, .topLeading,
        .topTrailing, .bottomLeading, .bottomTrailing
    ]
    
    @State var alignment: Alignment = .center
    
    var body: some View {
        VStack {
            Text("Mask")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack {
                Text("Mask default")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    // masks rectangle aligments
                    VStack {
                        Color.blue
                            .frame(width: 150, height: 150)
                            .mask(alignment: self.alignment) {
                                Rectangle()
                                    .frame(width: 60, height: 60)
                            }
                            .border(.red)
                        
                        Button("Random alignment") {
                            withAnimation {
                                self.alignment = self.alignments.filter { $0 != alignment }.randomElement()!
                            }
                        }
                    }
                    
                    // text mask
                    Color.blue
                        .frame(width: 100, height: 100)
                        .mask {
                            Text("Hello")
                                .fontWeight(.black)
                                .font(.system(size: 30))
                        }
                        .border(Color.red)
                }
            }
            .padding()
            
            VStack {
                Text("Mask opacity")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    
                    Image(systemName: "envelope.badge.fill")
                        .resizable()
                        .frame(width: 100, height: 80)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                        .mask(alignment: .leading) {
                            Rectangle()
                                .opacity(0.5)
                        }
                    
                    ZStack {
                        Color.blue
                            .frame(width: 100, height: 100)
                            .mask {
                                // The gradient color in the middle doesn't matter.
                                // replace it with .white, .red etc. The result would be the same.
                                LinearGradient(colors: [.clear, .black, .clear],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            }
                            .border(.red)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView()
    }
}

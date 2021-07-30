//
//  FontWeightView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/31.
//

import SwiftUI

struct FontWeightView: View {
    var body: some View {
        VStack {
            Text("Font Weight")
                .font(.title)
                .bold()
                .padding(.bottom, 30)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.black)
                    Text("black").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.bold)
                    Text("bold").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.heavy)
                    Text("heavy").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.light)
                    Text("light").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.medium)
                    Text("medium").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.regular)
                    Text("regular").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.semibold)
                    Text("semibold").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.thin)
                    Text("thin").borderedTextCaption()
                }
                
                HStack {
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        .fontWeight(.ultraLight)
                    Text("ultraLight").borderedTextCaption()
                }
            }
        }
    }
}

struct FontWeightView_Previews: PreviewProvider {
    static var previews: some View {
        FontWeightView()
    }
}


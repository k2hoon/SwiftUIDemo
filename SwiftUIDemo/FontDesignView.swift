//
//  FontDesignView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/31.
//

import SwiftUI

struct FontDesignView: View {
    var body: some View {
        VStack {
            Text("Font Design")
                .font(.title)
                .bold()
                .padding(.bottom, 30)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("default").borderedTextCaption()
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ").font(.system(.body, design: .default))
                    Text("가나다라바사아자차카타파하").font(.system(.body, design: .default))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("monospaced").borderedTextCaption()
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ").font(.system(.body, design: .monospaced))
                    Text("가나다라바사아자차카타파하").font(.system(.body, design: .monospaced))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("rounded").borderedTextCaption()
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ").font(.system(.body, design: .rounded))
                    Text("가나다라바사아자차카타파하").font(.system(.body, design: .rounded))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("serif").borderedTextCaption()
                    Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ").font(.system(.body, design: .serif))
                    Text("가나다라바사아자차카타파하").font(.system(.body, design: .serif))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
            }
        }
    }
}

struct FontDesignView_Previews: PreviewProvider {
    static var previews: some View {
        FontDesignView()
    }
}

//
//  FontTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/31.
//

import SwiftUI

struct FontTestView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Almost before we knew it, we had left the ground.")
            
            Text("Almost before we knew it, we had left the ground.")
                .font(Font.notoSansBold(size: 17))
            
            Text("Almost before we knew it, we had left the ground.")
                .font(.custom("NotoSansKR-Thin", size: 17))
            
            Text("Almost before we knew it, we had left the ground.")
                .font(.custom("NotoSansKR-Light", size: 17))
            
            Text("Almost before we knew it, we had left the ground.")
                .font(.custom("NotoSansKR-Medium", size: 17))
            
            Text("Almost before we knew it, we had left the ground.")
                .font(.custom("NotoSansKR-Regular", size: 17))
            
            Text("Almost before we knew it, we had left the ground.")
                .font(.custom("NotoSansKR-Bold", size: 17))
            
            Text("Almost before we knew it, we had left the ground.")
                .font(.custom("NotoSansKR-Black", size: 17))
            
            Text("Almost before we knew it, we had left the ground.")
                .font(.system(size: 17))
                .foregroundColor(.blue)
        }
    }
}

struct FontTestView_Previews: PreviewProvider {
    static var previews: some View {
        FontTestView()
    }
}

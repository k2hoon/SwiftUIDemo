//
//  CachedImageListRowView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI

struct CachedImageListRowView: View {
    @StateObject var imageLoader = ImageLoader()
    var urlString: String
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: (imageLoader.image ?? UIImage(systemName: "exclamationmark.triangle"))!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 42, height: 42, alignment: .center)
                
                VStack(alignment:.leading, spacing: 2) {
                    Circle()
                        .foregroundColor(self.imageLoader.error == nil ? .green : .red)
                        .frame(width: 14, height: 14, alignment: .center)
                        .scaledToFit()
                    
                    Text("some descprion...")
                }
                Spacer()
            }
            Text(self.urlString)
                .font(.caption)
                .lineLimit(1)
        }
        .frame(height: 84)
        .padding()
        .onAppear(perform: {
            self.imageLoader.loadWithCache(urlString: urlString)
        })
    }
}

struct CachedImageListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageListRowView(urlString: "https://www.themoviedb.org/t/p/w1280/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg")
            .previewLayout(.fixed(width: 335, height: 84))
    }
}

//
//  CachedImageListView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI

struct CachedImageListView: View {
    let images = [
        "https://www.themoviedb.org/t/p/w1280/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg",
        "https://www.themoviedb.org/t/p/w1280/kOVko9u2CSwpU8zGj14Pzei6Eco.jpg",
        "https://www.themoviedb.org/t/p/w1280/6PX0r5TRRU5y0jZ70y1OtbLYmoD.jpg",
        "https://www.themoviedb.org/t/p/w1280/A6dnHWe8YYcoFBHzP7T6WPP4b6F.jpg",
        "https://www.themoviedb.org/t/p/w1280/yBkZlG55CprznYxwUcGY6r3ZXP6.jpg",
        "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=http%3A%2F%2Fcfile27.uf.tistory.com%2Fimage%2F997C0E4D5CF880AE08AA17",
        "http://swiftdeveloperblog.com/wp-content/uploads/2015/07/1.jpeg"
    ].map { URL(string: $0)! }
    
    var body: some View {
        List {
            ForEach(images, id: \.self) { url in
                CachedImageListRowView(urlString: url.absoluteString)
            }
        }
    }
}

struct CachedImageListView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageListView()
    }
}

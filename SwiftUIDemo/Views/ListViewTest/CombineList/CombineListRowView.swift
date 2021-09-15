//
//  CombineListRowView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI

struct CombineListRowView<Placeholder: View>: View {
    
    //@StateObject var combineImageLoader = CombineImageLoader()
    @StateObject private var combineImageLoader: CombineImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    var urlString: String
    
    init(urlString: String,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self.placeholder = placeholder()
        self.image = image
        self.urlString = urlString
        //_viewModel = StateObject(wrappedValue: ImageViewModel())
        _combineImageLoader = StateObject(wrappedValue: CombineImageLoader(cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        VStack {
            if combineImageLoader.image == nil {
                placeholder
            } else {
                VStack {
                    HStack {
                        Image(uiImage: (combineImageLoader.image ?? UIImage(systemName: "exclamationmark.triangle"))!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 42, height: 42, alignment: .center)
                        
                        VStack(alignment:.leading, spacing: 2) {
                            Circle()
                                .foregroundColor(self.combineImageLoader.error == nil ? .green : .red)
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
            }
        }
        .frame(height: 84)
        .padding()
        .onAppear(perform: {
            self.combineImageLoader.loadSubcribe(urlString: urlString)
        })
    }
}

struct CombineListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CombineListRowView(urlString: "https://www.themoviedb.org/t/p/w1280/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg",
                           placeholder: {
                            Text("Sorry... Can not load image.")
                           },
                           image: Image.init(uiImage:))
            .previewLayout(.fixed(width: 335, height: 84))
    }
}

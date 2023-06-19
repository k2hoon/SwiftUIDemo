//
//  AttributedStringTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import SwiftUI

struct AttributedStringTestView: View {
   
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Text view with attributed string")
                    .underline()
                    .font(.title3)
                Spacer()
            }
            
            AttributedStringCollectionView()
            
            Divider()
            
            HStack {
                Text("Text view with weblink")
                    .underline()
                    .font(.title3)
                Spacer()
            }
            
            StringWebLinkView()
            
        }
    }
}

struct AttributedStringTestView_Previews: PreviewProvider {
    static var previews: some View {
        AttributedStringTestView()
    }
}

// MARK: - fit size attribute string text view
struct AttributedText: View {
    @State private var size: CGSize = .zero
    let attributedString: NSAttributedString
    
    init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }
    
    var body: some View {
        AttributedTextRepresentable(size: $size, attributedString: attributedString)
            .frame(width: size.width, height: size.height)
    }
    
    struct AttributedTextRepresentable: UIViewRepresentable {
        @Binding var size: CGSize
        let attributedString: NSAttributedString
        
        func makeUIView(context: Context) -> UILabel {
            let label = UILabel()
            
            label.lineBreakMode = .byClipping
            label.numberOfLines = 0
            
            return label
        }
        
        func updateUIView(_ uiView: UILabel, context: Context) {
            uiView.attributedText = attributedString
            DispatchQueue.main.async {
                size = uiView.sizeThatFits(uiView.superview?.bounds.size ?? .zero)
            }
        }
    }
}

// MARK: - Attributed String Collection Views
struct AttributedStringCollectionView: View {
    // sample attributed string
    let attributedString: NSMutableAttributedString = {
        let a1: [NSAttributedString.Key: Any] =
            [.foregroundColor: UIColor.systemRed,
             .kern: 5]
        let s1 = NSMutableAttributedString(string: "Hello World! ", attributes: a1)
        
        let a2: [NSAttributedString.Key: Any] =
            [.strikethroughStyle: 1,
             .strikethroughColor: UIColor.systemBlue]
        let s2 = NSMutableAttributedString(string: "strike through", attributes: a2)
        
        let a3: [NSAttributedString.Key: Any] = [.baselineOffset: 10]
        let s3 = NSMutableAttributedString(string: " raised ", attributes: a3)
        
        let a4: [NSAttributedString.Key: Any] =
            [.font: UIFont(name: "Papyrus", size: 25.0)!,
             .foregroundColor: UIColor.green]
        let s4 = NSMutableAttributedString(string: " papyrus font ", attributes: a4)
        
        let a5: [NSAttributedString.Key: Any] =
            [.foregroundColor: UIColor.systemBlue,
             .underlineStyle: 1,
             .underlineColor: UIColor.systemRed]
        let s5 = NSMutableAttributedString(string: "underlined ", attributes: a5)
        
        s1.append(s2)
        s1.append(s3)
        s1.append(s4)
        s1.append(s5)
        
        return s1
    }()
    
    var body: some View {
        VStack(spacing: 8) {
            // Using standard SwiftUI
            Text("Hello ")
                .foregroundColor(.red)
                + Text("World ")
                .fontWeight(.heavy)
                + Text("Strike through")
                .strikethrough()
            
            AttributedText(attributedString)
                .padding(10)
                .border(Color.red)
            
            // Ignore attributed string
            Text(attributedString.string)
                .padding(10)
                .border(Color.black)
            
            // Alernatively, Ignore attributed string
            Text(ignoreAttributedString: attributedString)
                .padding(10)
                .border(Color.black)
            
        }
    }
}

// MARK: - String WebLink Views
struct StringWebLinkView: View {
    var body: some View {
        // Using standard SwiftUI with text link
        HStack(spacing: 0) {
            Text("Go to ")
                .foregroundColor(.gray)
            
            Text("stack overflow")
                .foregroundColor(.blue)
                .underline()
                .onTapGesture {
                    let url = URL.init(string: "https://stackoverflow.com/")
                    guard let stackOverflowURL = url, UIApplication.shared.canOpenURL(stackOverflowURL) else { return }
                    UIApplication.shared.open(stackOverflowURL)
                }
            
            Text(" and enjoy")
                .foregroundColor(.gray)
        }
        
        AttributedStringHyperlink()
            .frame(width: 300, height: 110)
    }
}

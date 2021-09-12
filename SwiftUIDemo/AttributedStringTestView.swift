//
//  AttributedStringTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import SwiftUI

extension Text {
    init(ignoreAttributedString: NSAttributedString) {
        self.init(ignoreAttributedString.string)
    }
}

//struct AttributedText: UIViewRepresentable {
//
//    let attributedString: NSAttributedString
//
//    init(_ attributedString: NSAttributedString) {
//        self.attributedString = attributedString
//    }
//
//    func makeUIView(context: Context) -> UILabel {
//        let label = UILabel()
//
//        label.lineBreakMode = .byClipping
//        label.numberOfLines = 0
//
//        return label
//    }
//
//    func updateUIView(_ uiView: UILabel, context: Context) {
//        uiView.attributedText = attributedString
//    }
//}

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

extension NSMutableAttributedString {
    var range: NSRange {
        NSRange(location: 0, length: self.length)
    }
    
}

struct TappablePieceOfText: View {
    var body: some View {
        TextLabelWithHyperlink()
            .frame(width: 300, height: 110)
    }
}

struct TextLabelWithHyperlink: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UITextView {
        
        let standartTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        
        let attributedText = NSMutableAttributedString(string: "You can go to ")
        attributedText.addAttributes(standartTextAttributes, range: attributedText.range) // check extention
        
        let hyperlinkTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.link: "https://stackoverflow.com"
        ]
        
        let textWithHyperlink = NSMutableAttributedString(string: "stack overflow site")
        textWithHyperlink.addAttributes(hyperlinkTextAttributes, range: textWithHyperlink.range)
        attributedText.append(textWithHyperlink)
        
        let endOfAttrString = NSMutableAttributedString(string: " end enjoy it using old-school UITextView and UIViewRepresentable")
        endOfAttrString.addAttributes(standartTextAttributes, range: endOfAttrString.range)
        attributedText.append(endOfAttrString)
        
        let textView = UITextView()
        textView.attributedText = attributedText
        
        textView.isEditable = false
        textView.textAlignment = .center
        textView.isSelectable = true
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {}
    
}

struct AttributedStringTestView: View {
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
        VStack {
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
            
            TappablePieceOfText()
            
            Text("Hello ")
                .foregroundColor(.red)
                + Text("World ")
                .fontWeight(.heavy)
                + Text("Strike through")
                .strikethrough()
            
            AttributedText(attributedString)
                .padding(10)
                .border(Color.black)
            
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

struct AttributedStringTestView_Previews: PreviewProvider {
    static var previews: some View {
        AttributedStringTestView()
    }
}

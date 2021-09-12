//
//  AttributedString+Link.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/13.
//

import Foundation
import SwiftUI

extension Text {
    init(ignoreAttributedString: NSAttributedString) {
        self.init(ignoreAttributedString.string)
    }
}

extension NSMutableAttributedString {
    var range: NSRange {
        NSRange(location: 0, length: self.length)
    }
}

struct AttributedStringHyperlink: UIViewRepresentable {
    
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
        
        let endOfAttrString = NSMutableAttributedString(string: " end enjoy it using old UITextView and UIViewRepresentable")
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

//
//  AlertViewTextView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/03.
//


import SwiftUI

/// Description
struct AlertViewTextView: View {
    @State private var isShowAlert = false
    @State private var isShowAlertOther = false
    @State private var showTextLinkAlert = false
    @State private var showCustomAlert = false
    @State private var showTextFieldAlert = false
    
    let attributedLinkString: NSMutableAttributedString = {
        //
        let startTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        
        let attributedText = NSMutableAttributedString(string: "Can link to ")
        attributedText.addAttributes(startTextAttributes, range: attributedText.range)
        
        
        let hyperlinkTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.link: "https://www.apple.com/"
        ]
        
        let textWithHyperlink = NSMutableAttributedString(string: "apple site")
        textWithHyperlink.addAttributes(hyperlinkTextAttributes, range: textWithHyperlink.range)
        attributedText.append(textWithHyperlink)
        
        let endOfAttrString = NSMutableAttributedString(string: " and enjoy it")
        endOfAttrString.addAttributes(startTextAttributes, range: endOfAttrString.range)
        attributedText.append(endOfAttrString)
        
        return attributedText
    }()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                // Toggle Alert
                Button(action: { self.isShowAlert.toggle() },
                       label: { Text("SwiftUI Alert") })
                    .alert(isPresented: $isShowAlert) {
                        Alert(title: Text("Title"),
                              message: Text("message"),
                              dismissButton: .none)
                    }
                
                // Toggle Alert another
                Button(action: { self.isShowAlertOther.toggle() },
                       label: { Text("SwiftUI Alert (another)") })
                    .alert(isPresented: $isShowAlertOther) {
                        Alert(title: Text("Title"),
                              message: Text("message (another)"),
                              dismissButton: .none)
                    }
                
                // Toggle Alert Text Field
                Button(action: {
                    self.showTextFieldAlert.toggle()
                }, label: {
                    Text("Custom Alert Text Field")
                })
                
                // Toggle Custom Alert
                Button(action: {
                    self.showCustomAlert.toggle()
                }, label: {
                    Text("Custom Alert")
                })
//                .alert(isPresented: $showCustomAlert,
//                       AlertField(title: AlertField.Title(text: "hello", color: UIColor.white),
//                                  message: AlertField.Message(text: "world!", color: UIColor.white),
//                                  background: AlertField.Background(color: UIColor.gray, alpha: 0.7),
//                                  action: { action in
//
//                                  }))
                
                // Toggle Alert Text Link
                Button(action: {
                    self.showTextLinkAlert.toggle()
                }, label: {
                    Text("Custom Alert Link")
                })
            }
            if showTextLinkAlert {
                AlertTextLink($showTextLinkAlert, alert:
                                TextLinkdAlert(title: "Title",
                                               message: self.attributedLinkString,
                                               accept: "Accept", cancel: nil,
                                               action: {
                                                
                                               },
                                               secondaryActionTitle: "Deny",
                                               secondaryAction: {
                                                
                                               }))
            }
            
        }
        .alert(isPresented: $showTextFieldAlert,
               TextFieldAlert(
                title: "type message",
                message: "transferred over https",
                keyboardType: .default) { result in
                if let text = result {
                    guard let data = text.data(using: .utf8) else {
                        return
                    }
                    print(data)
                } else {
                    print("maybe canceled...")
                }
               })
    }
}

struct AlertViewTextView_Previews: PreviewProvider {
    static var previews: some View {
        AlertViewTextView()
    }
}

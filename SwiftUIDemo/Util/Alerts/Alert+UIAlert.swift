//
//  Alert+UIAlert.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/03.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    func alert(isPresented: Binding<Bool>, _ field: AlertField) -> some View {
        AlertControlView(isPresented, field: field, content: self)
    }
}


extension AlertControlView {
    // TODO: need to check setTint work.
    //    func setTint(color: UIColor) -> Void {
    //        self.content.tint
    //    }
}

struct AlertField {
    var title: Title? = nil
    var message: Message
    var accept: String = "OK"
    var cancel: String? = "Cancel"
    var background: Background? = nil
    var secondaryActionTitle: String? = nil
    var action: (String?) -> Void
    var secondaryAction: (() -> Void)? = nil
    
    struct Title {
        var text: String
        var color: UIColor
    }
    
    struct Message {
        var text: String
        var color: UIColor
    }
    
    struct Background {
        var color: UIColor
        var alpha: CGFloat
    }
    
    func setAction() -> Void {
        
    }
}

struct AlertControlView<Content: View>: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    private var field: AlertField
    private let content: Content
    
    init(_ isPresented: Binding<Bool>, field: AlertField, content: Content) {
        self._isPresented = isPresented
        self.field = field
        self.content = content
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    //    func makeUIViewController(context: Context) -> UIAlertController {
    //        let alertViewController = UIAlertController(title: "Hello", message: "Test alert", preferredStyle: .alert)
    //        let background = alertViewController.view.subviews.last?.subviews.last
    //        background?.layer.cornerRadius = 10.0
    //        background?.backgroundColor = UIColor(Color.green)
    //
    //
    //
    //        return alertViewController
    //    }
    //
    //    func updateUIViewController(_ uiViewController: UIAlertController, context: Context) {
    //
    //    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControlView>) -> UIHostingController<Content> {
        UIHostingController(rootView: self.content)
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertControlView>) {
        
        guard context.coordinator.alertController == nil else {
            return
        }
        //if isPresented && uiViewController.presentedViewController == nil {
        if isPresented {
            uiViewController.rootView = self.content
            let field = self.field
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            context.coordinator.alertController = alertController
            
            if let background = field.background {
                // Change Background
                //            let background = alertViewController.view.subviews.last?.subviews.last
                //            background?.layer.cornerRadius = 10.0
                //            background?.backgroundColor = UIColor(Color.green)
                
                if let bgView = alertController.view.subviews.first,
                   let groupView = bgView.subviews.first,
                   let contentView = groupView.subviews.first {
                    contentView.backgroundColor = background.color.withAlphaComponent(background.alpha)
                }
            }
            
            // Change title
            if let title = field.title {
                let text = title.text
                let attributeTitle = NSMutableAttributedString(string: text)
                attributeTitle.addAttributes(
                    [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26)],
                    range: NSMakeRange(0, text.utf8.count))
                
                attributeTitle.addAttributes(
                    [NSAttributedString.Key.foregroundColor: title.color],
                    range: NSMakeRange(0, text.utf8.count))
                
                alertController.setValue(attributeTitle, forKey: "attributedTitle")
            }
            
            // Chage Message
            let message = field.message
            let text = message.text
            let attributeMessage = NSMutableAttributedString(string: text)
            attributeMessage.addAttributes(
                [NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 18)!],
                range: NSMakeRange(0, text.utf8.count))
            
            attributeMessage.addAttributes(
                [NSAttributedString.Key.foregroundColor: message.color],
                range: NSMakeRange(0, text.utf8.count))
            
            alertController.setValue(attributeMessage, forKey: "attributedMessage")
            
            
            // Add Action
            // handler can be null
            //alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            // tint color change
            //alertViewController.view.tintColor = UIColor.gray
            
            // Add Action
            let action = UIAlertAction(title: field.accept, style: .default, handler: nil)
            action.setValue(UIColor.blue, forKey: "titleTextColor")
            alertController.addAction(action)
            
            DispatchQueue.main.async {
                uiViewController.present(alertController, animated: true) {
                    isPresented = false
                    context.coordinator.alertController = nil
                }
            }
            
        }        
    }
    
    class Coordinator: NSObject {
        var alertController: UIAlertController?
        
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }
}

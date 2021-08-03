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
    
    func alert(isPresented: Binding<Bool>) -> some View {
        AlertControl(isPresented, content: self)
    }
}

extension AlertControl {
//    func setTint(color: UIColor) -> Void {
//        //self.content.tint
//    }
}
struct AlertControl<Content: View>: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    private let content: Content
    
    init(_ isPresented: Binding<Bool>, content: Content) {
        self._isPresented = isPresented
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
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControl>) -> UIHostingController<Content> {
        UIHostingController(rootView: self.content)
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertControl>) {
        uiViewController.rootView = self.content
        
        if isPresented && uiViewController.presentedViewController == nil {
            
            let alertViewController = UIAlertController(title: "Hello", message: "Test alert", preferredStyle: .alert)
            // Change Background
//            let background = alertViewController.view.subviews.last?.subviews.last
//            background?.layer.cornerRadius = 10.0
//            background?.backgroundColor = UIColor(Color.green)
            
            if let bgView = alertViewController.view.subviews.first,
               let groupView = bgView.subviews.first,
               let contentView = groupView.subviews.first {
                contentView.backgroundColor = UIColor(Color.black).withAlphaComponent(0.7)
            }
            
            // Change title
            let title = "Hello"
            let attributeTitle = NSMutableAttributedString(string: title)
            attributeTitle.addAttributes(
                [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26)],
                range: NSMakeRange(0, title.utf8.count))
                                           
            attributeTitle.addAttributes(
                [NSAttributedString.Key.foregroundColor: UIColor.red],
                range: NSMakeRange(0, title.utf8.count))

            alertViewController.setValue(attributeTitle, forKey: "attributedTitle")
            
            // Chage Message
            let message = "Test alert"
            let attributeMessage = NSMutableAttributedString(string: message)
            attributeMessage.addAttributes(
                [NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 18)!],
                range: NSMakeRange(0, message.utf8.count))
                                           
            attributeMessage.addAttributes(
                [NSAttributedString.Key.foregroundColor: UIColor.blue],
                range: NSMakeRange(0, message.utf8.count))

            alertViewController.setValue(attributeMessage, forKey: "attributedMessage")
            
            
            // Add Action
            // handler can be null
            //alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            // tint color change
            //alertViewController.view.tintColor = UIColor.gray
            
            // Add Action
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            action.setValue(UIColor.gray, forKey: "titleTextColor")
            alertViewController.addAction(action)
            
            context.coordinator.alertController = alertViewController
            uiViewController.present(context.coordinator.alertController!, animated: true)
            
            
        }
        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }
    
    class Coordinator: NSObject {
        var alertController: UIAlertController?
        
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }
    
}

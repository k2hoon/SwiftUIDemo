//
//  Alert+TextLink.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import Foundation
import SwiftUI

struct TextLinkdAlert {
    var title: String
    var message: NSMutableAttributedString
    var accept: String = "OK"
    var cancel: String? = "Cancel"
    var action: () -> Void
    var secondaryActionTitle: String? = nil
    var secondaryAction: (() -> Void)? = nil
}

struct AlertTextLink: UIViewControllerRepresentable {
    
    private var alert: TextLinkdAlert
    @Binding var isPresented: Bool
    
    init(_ isPresented: Binding<Bool>, alert: TextLinkdAlert) {
        self._isPresented = isPresented
        self.alert = alert
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertTextLink>) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AlertTextLink>) {
        guard context.coordinator.alertController == nil else {
            return
        }
        
        if isPresented {
            
            var alert = self.alert
            alert.action = {
                self.isPresented = false
                self.alert.action()
            }
            
            let alertController = UIAlertController(title: alert.title,
                                                    message: nil,
                                                    preferredStyle: .alert)
            
            context.coordinator.alertController = alertController
            
            let controller = UIViewController()
            
            let textView = UITextView()
            textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            textView.frame = controller.view.frame
            textView.backgroundColor = .clear
            
            // set attributed String here.
            textView.attributedText = alert.message
            textView.isEditable = false
            textView.textAlignment = .center
            textView.isSelectable = true
            
            controller.view.addSubview(textView)
            alertController.setValue(controller, forKey: "contentViewController")
            
            // maybe not need...
            let height: NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 150)
            alertController.view.addConstraint(height)
            
            // Add usual action
            alertController.addAction(UIAlertAction(title: alert.accept, style: .default, handler: { (_) in
                alert.action()
            }))
            
            if let cancel = alert.cancel {
                alertController.addAction(UIAlertAction(title: cancel, style: .cancel))
            }
            
            if let secondaryActionTitle = alert.secondaryActionTitle {
                alertController.addAction(UIAlertAction(title: secondaryActionTitle,
                                                        style: .destructive, handler: { _ in
                                                            alert.secondaryAction?()
                                                        }))
            }
            
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

//
//  Alert+TextField.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import Foundation
import SwiftUI

struct TextFieldAlert {
    var title: String
    var message: String
    var placeHolder: String = ""
    var accept: String = "OK"
    var cancel: String? = "Cancel"
    var secondaryActionTitle: String? = nil
    var keyboardType: UIKeyboardType = .default
    var action: (String?) -> Void
    var secondaryAction: (() -> Void)? = nil
}

/*
 struct AlertTextField: UIViewControllerRepresentable {
 private var alert: TextFieldAlert
 @Binding var isPresented: Bool
 
 init(_ isPresented: Binding<Bool>, alert: TextFieldAlert) {
 self._isPresented = isPresented
 self.alert = alert
 }
 
 func makeCoordinator() -> Coordinator {
 Coordinator()
 }
 
 func makeUIViewController(context: UIViewControllerRepresentableContext<AlertTextField>) -> UIViewController {
 UIViewController()
 }
 
 
 func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AlertTextField>) {
 guard context.coordinator.alertController == nil else {
 return
 }
 
 if isPresented {
 var alert = self.alert
 alert.action = {
 self.isPresented = false
 self.alert.action($0)
 }
 
 let alertController = UIAlertController(title: alert.title,
 message: alert.message,
 preferredStyle: .alert)
 
 if let cancel = alert.cancel {
 alertController.addAction(UIAlertAction(
 title: cancel,
 style: .cancel,
 handler: { _ in
 alert.action(nil)
 }))
 }
 
 if let secondaryActionTitle = alert.secondaryActionTitle {
 alertController.addAction(UIAlertAction(title: secondaryActionTitle,
 style: .default,
 handler: { (_) in
 alert.secondaryAction?()
 
 }))
 }
 
 // Add Text Field
 alertController.addTextField { (textfield) in
 textfield.placeholder = alert.placeHolder
 textfield.keyboardType = alert.keyboardType
 }
 
 alertController.addAction(UIAlertAction(title: alert.accept, style: .default, handler: { (_) in
 alert.action(alertController.textFields?.first?.text)
 }))
 
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
 */


extension View {
    func alert(isPresented: Binding<Bool>, _ alert: TextFieldAlert) -> some View {
        AlertTextField(isPresented, alert: alert, content: self)
    }
}

struct AlertTextField<Content: View>: UIViewControllerRepresentable {
    
    private var alert: TextFieldAlert
    private let content: Content
    @Binding var isPresented: Bool
    
    init(_ isPresented: Binding<Bool>, alert: TextFieldAlert, content: Content) {
        self._isPresented = isPresented
        self.alert = alert
        self.content = content
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    ///
    /// - Parameter context: context description
    /// - Returns: description
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertTextField>) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertTextField>) {
        uiViewController.rootView = content
        if isPresented && uiViewController.presentedViewController == nil {
            var alert = self.alert
            alert.action = {
                self.isPresented = false
                self.alert.action($0)
            }
            
            let alertController = UIAlertController(title: alert.title,
                                                    message: alert.message,
                                                    preferredStyle: .alert)
            if let cancel = alert.cancel {
                alertController.addAction(UIAlertAction(
                                            title: cancel,
                                            style: .cancel,
                                            handler: { _ in
                                                alert.action(nil)
                                            }))
            }
            
            if let secondaryActionTitle = alert.secondaryActionTitle {
                alertController.addAction(UIAlertAction(title: secondaryActionTitle, style: .default, handler: { (_) in
                    alert.secondaryAction?()
                }))
            }
            
            alertController.addTextField { (textfield) in
                textfield.placeholder = alert.placeHolder
                textfield.keyboardType = alert.keyboardType
            }
            
            alertController.addAction(UIAlertAction(title: alert.accept, style: .default, handler: { (_) in
                alert.action(alertController.textFields?.first?.text)
            }))
            
            context.coordinator.alertController = alertController
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
    
    //    class Coordinator: NSObject, UITextFieldDelegate {
    //        var parent: AlertTextField
    //
    //        init(_ alert: AlertTextField) {
    //            self.parent = alert
    //        }
    //
    //        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //            if let text = textField.text {
    //                self.parent.message = text
    //            } else {
    //                self.parent.message = ""
    //            }
    //            return true
    //        }
    //    }
}

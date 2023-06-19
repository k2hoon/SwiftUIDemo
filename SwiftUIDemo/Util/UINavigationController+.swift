//
//  UINavigationController+.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/06/19.
//

import Foundation
import UIKit

extension UINavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

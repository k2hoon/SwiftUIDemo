//
//  PinchView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2022/12/26.
//

import Foundation
import SwiftUI

struct PinchView: UIViewControllerRepresentable {
    var imagename: String
    
    func makeUIViewController(context: Context) -> PinchViewController {
        PinchViewController(imagename: self.imagename)
    }

    func updateUIViewController(_ uiViewController: PinchViewController, context: Context) {

    }
}

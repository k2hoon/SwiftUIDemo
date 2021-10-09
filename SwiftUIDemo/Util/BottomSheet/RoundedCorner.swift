//
//  RoundedCorner.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/20.
//

import Foundation
import SwiftUI

/// Rounded corner shape that provides an adjustable square corner ratio with rounded corners.
fileprivate struct RoundedCorner: Shape {
    fileprivate var radius: CGFloat = .infinity
    fileprivate var corners: UIRectCorner = .allCorners

    fileprivate func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCorner(radius: radius, corners: corners)
        )
    }
}

struct RoundedCorner_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

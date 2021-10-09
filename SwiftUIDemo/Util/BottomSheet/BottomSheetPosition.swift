//
//  BottomSheetPosition.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/20.
//

import Foundation
import SwiftUI

/// The default BottomSheetPosition it the following cases and values: `top = 0.975`,  `middle = 0.4`,  `bottom = 0.125`,  `hidden = 0`
///
/// Can create custom BottomSheetPosition enum:
/// - enum must conforms to `CGFloat` and `CaseIterable`
/// - The case  `rawValue == 0` is hiding the BottomSheet
/// - The value can be  between  from `0` to `1` (`x <= 1`, `x >= 0`)
public enum BottomSheetPosition: CGFloat, CaseIterable {
    //The case where the height of the BottomSheet is 97.5%
    case top = 0.975
    //The case where the height of the BottomSheet is 40%
    case middle = 0.4
    //The case where the height of the BottomSheet is 12.5% and the `mainContent` is hidden
    case bottom = 0.125
    //The case where the BottomSheet is hidden
    case hidden = 0
}

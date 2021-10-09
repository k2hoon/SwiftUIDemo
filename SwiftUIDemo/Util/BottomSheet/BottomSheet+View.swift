//
//  extension.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/20.
//

import Foundation
import SwiftUI

@available(iOSApplicationExtension, unavailable)
public extension View {
    
    /// A modifer to add a BottomSheet to view.
    /// - Parameter bottomSheetPosition: A binding that saves the current state of the BottomSheet. For more information about custom enums see `BottomSheetPosition`.
    /// - Parameter options: An array that contains the settings / options for the BottomSheet. Can be `nil`. For more information about the possible options see `BottomSheet.Options`.
    /// - Parameter Header: A view that is used as header content for the BottomSheet.
    /// - Parameter Content: A view that is used as main content for the BottomSheet.
    /// - Returns: View
    func bottomSheet<Header, Content, PositionEnum: RawRepresentable>(bottomSheetPosition: Binding<PositionEnum>,
                                                                      options: [BottomSheet.Options] =  [],
                                                                      @ViewBuilder header: () -> Header,
                                                                      @ViewBuilder content: () -> Content) -> some View where Header: View,
                                                                                                                              Content: View,
                                                                                                                              PositionEnum.RawValue == CGFloat,
                                                                                                                              PositionEnum: CaseIterable
    {
        ZStack {
            self
            BottomSheetView(sheetPosition: bottomSheetPosition, options: options, header: header, content: content)
        }
                                                                                                                                  
    }
    
    
//    func bottomSheet<Header, Content, PositionEnum: RawRepresentable>(bottomSheetPosition: Binding<PositionEnum>, options: [BottomSheet.Options] =  [],
//                                                                                  @ViewBuilder header: () -> Header? = { return nil },
//    @ViewBuilder main content: () -> Content) -> some View where Header: View, Content: View, PositionEnum.RawValue == CGFloat, PositionEnum: CaseIterable {
//        ZStack {
//            self
//            BottomSheetView(sheetPosition: bottomSheetPosition, options: options, header: header, main: content)
//        }
//    }
    
    /// A modifer to add a BottomSheet to your view.
    /// - Parameter bottomSheetPosition: A binding that saves the current state of the BottomSheet. For more information about custom enums see `BottomSheetPosition`.
    /// - Parameter options: An array that contains the settings / options for the BottomSheet. For more information about the possible options see `BottomSheet.Options`.
    /// - Parameter title: A string that is used as the title for the BottomSheet. Can be `nil`. You can use a view that is used as header content for the BottomSheet instead.
    /// - Parameter content: A view that is used as content for the BottomSheet.
    /// - Returns: View
    func bottomSheet<Content: View, PositionEnum: RawRepresentable>(bottomSheetPosition: Binding<PositionEnum>,
                                                                    options: [BottomSheet.Options] = [],
                                                                    title: String? = nil,
                                                                    @ViewBuilder content: () -> Content) -> some View where
    PositionEnum.RawValue == CGFloat, PositionEnum: CaseIterable {
        ZStack {
            self
            BottomSheetView(sheetPosition: bottomSheetPosition, options: options, title: title, content: content)
        }
    }
}

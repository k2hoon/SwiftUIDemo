//
//  PicketTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/03.
//

import SwiftUI

struct PickerTestView: View {
    @State var selection: Int = 0
    private let items: [String] = ["A", "B", "C", "D", "E"]
    
    var body: some View {
        SegmentedPicker(items: self.items, selection: self.$selection)
            .padding()
    }
}

struct PickerTestView_Previews: PreviewProvider {
    static var previews: some View {
        PickerTestView()
    }
}

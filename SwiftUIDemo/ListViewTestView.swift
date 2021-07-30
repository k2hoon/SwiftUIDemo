//
//  ListViewTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/27.
//

import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct ListViewTestView: View {
    struct Ocean: Identifiable, Hashable {
        let name: String
        let id = UUID()
    }
    
    private var oceans = [
        Ocean(name: "Pacific"),
        Ocean(name: "Atlantic"),
        Ocean(name: "Indian"),
        Ocean(name: "Southern"),
        Ocean(name: "Arctic")
    ]
    @State private var multiSelection = Set<UUID>()
    
    @State var items: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos", "Grapefruit"]
    @State var selections: [String] = []
    
    var body: some View {
        List {
            ForEach(self.items, id: \.self) { item in
                MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                    if self.selections.contains(item) {
                        self.selections.removeAll(where: { $0 == item })
                    }
                    else {
                        self.selections.append(item)
                    }
                }
            }
        }
        //        NavigationView {
        //            VStack {
        //                Text("\(multiSelection.count) selections")
        //                List(oceans, selection: $multiSelection) {
        //                    Text($0.name)
        //                }
        //                .navigationTitle("Oceans")
        //                .toolbar { EditButton() }
        //            }
        //        }
        
    }
}

struct ListViewTestView_Previews: PreviewProvider {
    static var previews: some View {
        ListViewTestView()
    }
}

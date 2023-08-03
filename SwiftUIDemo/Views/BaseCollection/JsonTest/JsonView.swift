//
//  JsonView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/23.
//

import SwiftUI

struct JsonView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewmodel = JsonViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                Text(self.viewmodel.dictionaryToJson())
                Text(self.viewmodel.stringDictionaryToJsonObject())
                Text(self.viewmodel.stringArrayToJsonObject())
            }
            .navigationTitle("Json Test")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct JsonView_Previews: PreviewProvider {
    static var previews: some View {
        JsonView(viewmodel: JsonViewModel())
    }
}

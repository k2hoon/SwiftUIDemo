//
//  JsonView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/23.
//

import SwiftUI

struct JsonView: View {
    @StateObject var viewmodel = JsonViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text(self.viewmodel.dictionaryToJson())
            Text(self.viewmodel.stringDictionaryToJsonObject())
            Text(self.viewmodel.stringArrayToJsonObject())
        }
    }
}

struct JsonView_Previews: PreviewProvider {
    static var previews: some View {
        JsonView(viewmodel: JsonViewModel())
    }
}

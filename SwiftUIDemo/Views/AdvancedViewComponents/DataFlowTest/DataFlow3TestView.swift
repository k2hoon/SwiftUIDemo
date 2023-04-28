//
//  DataFlow3TestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/29.
//

import SwiftUI

struct DataFlow3TestView: View {
    var body: some View {
        VStack {
            SubView1()
            
            Divider()
            
            Subview2()
        }
        .environmentObject(AppEnvrionment())
    }
}

struct DataFlow3TestView_Previews: PreviewProvider {
    static var previews: some View {
        DataFlow3TestView()
    }
}

// MARK: Sub view
extension DataFlow3TestView {
    struct SubView1: View {
        @EnvironmentObject private var appEnv: AppEnvrionment
        @StateObject private var viewModel = SubView1Model()
        
        var body: some View {
            VStack {
                Text(self.viewModel.shared.literalString)
            }
        }
    }
    
    struct Subview2: View {
        @EnvironmentObject private var appEnv: AppEnvrionment
        @StateObject private var viewModel = SubView2Model()
        
        var body: some View {
            VStack {
                Button("View Update by Environment") { self.appEnv.viewUpdate.toggle() }
                
                Button("View Update by ViewModel") { self.viewModel.viewUpdate.toggle() }
                
                Button("Change string") { self.viewModel.shared.literalString = "View Update!!" }
            }
        }
    }
}

// MARK: ViewModel
extension DataFlow3TestView {
    // The class does not affect view updates
    class BaseViewModel: ObservableObject {
        @Published var viewUpdate = false
        var shared = AppShared.shared
    }
    
    class AppShared {
        static let shared = AppShared()
        var literalString: String = ""
    }
    
    class AppEnvrionment: ObservableObject {
        @Published var viewUpdate = false
    }
    
    class SubView1Model: BaseViewModel { }
    
    class SubView2Model: BaseViewModel { }
}

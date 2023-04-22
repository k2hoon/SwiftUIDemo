//
//  SettingsView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appEnv: AppEnvrionment
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            Button("toggle") {
                self.appEnv.toggle.toggle()
            }
            
            Button("show") {
                self.viewModel.setAlertError()
            }
            
            Text("Hello, SettingsView!")
                
        }
        .onAppear {
            print("SettingsView::onAppear")
            self.viewModel.invoke()
        }
        .onDisappear {
            print("SettingsView::onDisappear")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//
class SettingsViewModel: BaseViewModel {
    
    override init() {
        print("SettingsViewModel::init")
    }
    
    deinit {
        print("SettingsViewModel::deinit")
    }
    
    func invoke() {
        print("SettingsViewModel::invoke")
    }
}

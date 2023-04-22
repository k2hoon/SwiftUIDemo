//
//  TestingView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/23.
//

import SwiftUI

struct TestingView: View {
    @EnvironmentObject var appEnv: AppEnvrionment
    @StateObject var viewModel = TestingViewModel()
    
    var body: some View {
        VStack {
            if self.appEnv.toggle {
                Text("Hello, AdvancedView! true")
                    .onAppear {
                        print("AdvancedView::onAppear")
                        self.viewModel.invoke()
                    }
            } else {
                Text("Hello, AdvancedView! false")
            }
            
            if self.viewModel.show {
                Text("Hello, show! true")
                    .onAppear {
                        print("AdvancedView::onAppear")
                    }
                    .onDisappear {
                        print("AdvancedView::onDisappear")
                    }
                
            } else {
                Text("Hello, show! false")
            }
        }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
            .environmentObject(AppEnvrionment())
    }
}

//
class TestingViewModel: BaseViewModel {
    
    override init() {
        print("AdvancedViewModel::init")
    }
    
    deinit {
        print("AdvancedViewModel::deinit")
    }
    
    func invoke() {
        print("AdvancedViewModel::invoke")
    }
}

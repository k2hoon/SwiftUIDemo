//
//  DataFlow2TestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/02/05.
//

import SwiftUI

struct DataFlow2TestView: View {
    @StateObject var viewModel = DataFlowViewModel()
    
    var body: some View {
        VStack {
            // StateObject
            VStack {
                Text("StateObject")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    PublishedValue(value: self.viewModel.firstValue)
                    
                    PublishedBindValue(value: self.$viewModel.secondValue)
                }
                
                Button("Increate first value") {
                    self.viewModel.firstValue += 1
                }
                
                Button("Change both to 100") {
                    self.viewModel.firstValue = 100
                    self.viewModel.secondValue = 100
                }
                
                Divider()
            }
            
            // ObservedObject
            VStack {
                Text("ObservedObject")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ObservedView(viewModel: self.viewModel)
                
                Divider()
            }
            
            // EnvironmentObject
            VStack {
                Text("EnvironmentObject")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                EnvironmentView()
                    .environmentObject(self.viewModel)
            }
        }
        .padding()
    }
    
    struct PublishedValue: View {
        let value: Int
        
        var body: some View {
            Text("let first: \(self.value)")
                .padding()
                .border(Color.black)
                .background(Color.random)
        }
    }
    
    struct PublishedBindValue: View {
        @Binding var value: Int
        
        var body: some View {
            Text("binding: \(self.value)")
                .padding()
                .border(Color.black)
                .background(Color.random)
        }
    }
}

struct DataFlowTest2View_Previews: PreviewProvider {
    static var previews: some View {
        DataFlow2TestView()
    }
}

// MARK: Observed sub view
extension DataFlow2TestView {
    struct ObservedView: View {
        @ObservedObject var viewModel: DataFlowViewModel
        
        var body: some View {
            VStack {
                Toggle(isOn: self.$viewModel.isEnabled) {
                    Text("Toggle view")
                }
                .padding()
                
                Text("observed: \(self.viewModel.firstValue)")
                    .padding()
                    .border(Color.black)
                    .background(Color.random)
                
                Button("Toggle switch") {
                    self.viewModel.isEnabled.toggle()
                }
                
                Button("Increate first value") {
                    self.viewModel.firstValue += 1
                }
            }
        }
    }
}

// MARK: Environment sub view
extension DataFlow2TestView {
    struct EnvironmentView: View {
        @EnvironmentObject private var viewModel: DataFlowViewModel
        
        var body: some View {
            VStack {
                Toggle(isOn: self.$viewModel.isEnabled) {
                    Text("Toggle view")
                }
                .padding()
                
                Text("environment second value: \(self.viewModel.secondValue)")
                    .padding()
                    .border(Color.black)
                    .background(Color.random)
                
                Button("Toggle switch") {
                    self.viewModel.isEnabled.toggle()
                }
                
                Button("Increate second value") {
                    self.viewModel.secondValue += 1
                }
            }
        }
    }
}

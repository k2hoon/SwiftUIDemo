//
//  DataFlowTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/02/03.
//

import SwiftUI

struct DataFlowTestView: View {
    // State property
    @State var firstValue = 0
    @State var secondValue = 0
    @State var textValue = "Before"
    
    // State sub view property
    @State var firstSubValue = 0
    @State var secondSubValue = 0
    @State var textSubValue = "Before"
    
    // Binding property
    @State var value = 0
    @State var bindValue = 0
    
    // StateObject property
    @StateObject var viewModel = DataFlowViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button("Reset") {
                    self.firstValue = 0
                    self.secondValue = 0
                    self.textValue = "Before"
                    self.value = 0
                    self.bindValue = 0
                    self.viewModel.firstValue = 0
                    self.viewModel.secondValue = 0
                }
                
                Spacer()
            }
            .padding(.bottom, 16)
            
            
            // State
            VStack {
                Text("State")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("First: \(self.firstValue)")
                        .padding()
                        .border(Color.black)
                        .background(Color.random)
                    
                    Text("Second: \(self.secondValue)")
                        .padding()
                        .border(Color.black)
                        .background(Color.random)
                    
                    Text(self.textValue)
                        .padding()
                        .border(Color.black)
                        .background(Color.random)
                }
                
                
                Button("Increase first value") {
                    self.firstValue += 1
                }
                
                Button("Change text before to after") {
                    self.textValue = "After"
                }
                
                Divider()
            }
            
            // State Sub
            VStack {
                Text("State SubView")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    FistValueView(value: self.firstSubValue)
                    
                    SecondValueView(value: self.secondSubValue)
                    
                    TextValueView(value: self.textSubValue)
                }
                
                
                Button("Increase first value") {
                    self.firstSubValue += 1
                }
                
                Button("Change text before to after") {
                    self.textSubValue = "After"
                }
                
                Divider()
            }
            
            // Binding
            VStack {
                Text("Binding")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    ValueView(value: self.value)
                    
                    BindingValue(value: $bindValue)
                }
                
                Button("Increase value") {
                    self.value += 1
                }
                
                Button("Increase bind value") {
                    self.bindValue += 1
                }
                
                Button("Change both to 100") {
                    self.value = 100
                    self.bindValue = 100
                }
                
                Divider()
            }
            
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
        }
        .padding()
    }
}

extension Color {
    static var random: Color {
        Color(red: .random(in: 0...1.0),
              green: .random(in: 0...1.0),
              blue: .random(in: 0...1.0))
    }
}

struct DataFlowTestView_Previews: PreviewProvider {
    static var previews: some View {
        DataFlowTestView()
    }
}

// MARK: State subview
extension DataFlowTestView {
    struct FistValueView: View {
        let value: Int
        
        var body: some View {
            Text("first: \(self.value)")
                .padding()
                .border(Color.black)
                .background(Color.random)
        }
    }
    
    struct SecondValueView: View {
        let value: Int
        
        var body: some View {
            Text("second: \(self.value)")
                .padding()
                .border(Color.black)
                .background(Color.random)
        }
    }
    
    struct TextValueView: View {
        let value: String
        
        var body: some View {
            Text(self.value)
                .padding()
                .border(Color.black)
                .background(Color.random)
        }
    }
}

// MARK: Binding subview
extension DataFlowTestView {
    struct ValueView: View {
        let value: Int
        
        var body: some View {
            Text("let: \(self.value)")
                .padding()
                .border(Color.black)
                .background(Color.random)
        }
    }
    
    struct BindingValue: View {
        @Binding var value: Int
        
        var body: some View {
            Text("binding: \(self.value)")
                .padding()
                .border(Color.black)
                .background(Color.random)
        }
    }
}

// MARK: StateObject subview
extension DataFlowTestView {
    struct PublishedValue: View {
        let value: Int
        
        var body: some View {
            Text("let: \(self.value)")
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

//
//  CombineTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/02.
//

import SwiftUI

struct CombineTestView: View {
    @StateObject var viewModel = CombineViewModel()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Text("Hello, Combine!")
                .onReceive(timer) { time in
                    if self.counter == 5 {
                        self.timer.upstream.connect().cancel()
                    } else {
                        self.counter += 1
                    }                    
                }
            
            Text("The timer counter is: \(counter)")
            
            
            Text("Hello, Combine!")
            Text("This is : \(self.viewModel.notified)")
            Button(action: {
                self.viewModel.sampleCurrentValueSubject()
            }, label: {
                Text("Post Button")
            })
            
            Button(action: {
                self.viewModel.sampleSubject()
            }, label: {
                Text("Post Button")
            })
            //Text("Hello, World! value changed: \(self.viewModel.value)")
            //ProgressTestView(viewModel: self.viewModel)
            
//            Button(action: {
//                self.viewModel.count += 1
//            }, label: {
//                Text("Increase Button")
//            })
            
            //Text("Hello, World! button selected: \(self.viewModel.count)")
        }
    }
}

struct CombineTestView_Previews: PreviewProvider {
    static var previews: some View {
        CombineTestView()
    }
}

// MARK: -

struct ProgressTestView: View {
    @ObservedObject var viewModel: CombineViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView(value: viewModel.progressValue)
            Button(action: {
                viewModel.increaseProgress()
            }, label: {
                Text("Button")
            })
            VStack {
                ProgressView(value: 0.25)
                ProgressView(value: 0.75)
            }
            .progressViewStyle(DarkBlueShadowProgressViewStyle())
        }
        .padding()
    }
}

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                                radius: 4.0, x: 1.0, y: 2.0)
    }
}

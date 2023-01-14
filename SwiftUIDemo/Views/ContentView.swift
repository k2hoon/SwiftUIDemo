//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/03/15.
//

import SwiftUI


struct ContentView: View {
    @State private var isWebLinkTestActive = false
    @State private var isAttrStringTestActive = false
    @State private var isAlertTestActive = false
    @State private var isCombineTestActive = false
    @State private var isCacheImageListActive = false
    @State private var isCoreDataTestActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello. This is...")
                    .font(.headline)
                    .padding()
                HStack {
                    Text("""
                    This is somethig to explain....
                    """)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                NavigationLink(
                    destination: WebLinkTestView(),
                    isActive: $isWebLinkTestActive,
                    label: {
                        Button(action: {
                            self.isWebLinkTestActive.toggle()
                        }, label: {
                            Text("WebLink TestView")
                        })
                    })
                
                NavigationLink(
                    destination: AttributedStringTestView(),
                    isActive: $isAttrStringTestActive,
                    label: {
                        Button(action: {
                            self.isAttrStringTestActive.toggle()
                        }, label: {
                            Text("AttributedString TestView")
                        })
                    })
                
                NavigationLink(
                    destination: AlertViewTextView(),
                    isActive: $isAlertTestActive,
                    label: {
                        Button(action: {
                            self.isAlertTestActive.toggle()
                        }, label: {
                            Text("AlertTestActive TestView")
                        })
                    })
                
                NavigationLink(
                    destination: CombineTestView(),
                    isActive: $isCombineTestActive,
                    label: {
                        Button(action: {
                            self.isCombineTestActive.toggle()
                        }, label: {
                            Text("CombineTest TestView")
                        })
                    })
                
                NavigationLink(
                    destination: CombineListView(),
                    isActive: $isCacheImageListActive,
                    label: {
                        Button(action: {
                            self.isCacheImageListActive.toggle()
                        }, label: {
                            Text("Cache Image List TestView")
                        })
                    })
                
                NavigationLink(
                    destination: CoreDataTestView(),
                    isActive: $isCoreDataTestActive,
                    label: {
                        Button(action: { self.isCoreDataTestActive.toggle() }) {
                            Text("Core Data Test View")
                        }
                    })
                
                
            }
        }
        .navigationTitle("")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

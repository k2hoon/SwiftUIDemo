//
//  NavigationToolbarView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/09.
//

import SwiftUI

struct NavigationToolbarView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color.gray)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                
                NavigationLink(destination: NavigationToolbarDetailView()) {
                    Text("Go to detail view")
                        .foregroundColor(.black)
                        .padding()
                        .border(Color.blue)
                    
                }
                .navigationTitle("") // empty string
                .navigationBarTitleDisplayMode(.inline) //The settings are retained in the next view
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("hello")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 45)
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 56, height: 56, alignment: .center)
                        }
                        
                        Button("About") {
                            print("About tapped!")
                        }
                        .frame(height: 255, alignment: .center)
                        
                        Button("Help") {
                            print("Help tapped!")
                        }
                    }
                    
                }
            }
            .onAppear {
                print("NavigationToolbarView height", UINavigationBar.appearance().frame)
                print("NavigationToolbarView height", UINavigationBar.appearance().bounds.height)
            }
        }
    }
}

struct NavigationToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToolbarView()
    }
}

struct NavigationToolbarDetailView: View {
    var body: some View {
        Text("Hello, Toolbar Detail View!")
            .navigationBarTitle("Toolbar Detail View")
    }
}

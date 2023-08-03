//
//  WebLinkTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import SwiftUI
import WebKit

/// Test with moving to website using url
/// see that link https://github.com/stleamist/BetterSafariView
struct WebLinkTestView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    @State var showSFSafariSheet = false
    @State var showWebKitSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                // Link view case 1
                Link("Link to SwiftUI",
                     destination: URL(string: "https://developer.apple.com/documentation/swiftui")!)
                
                // Link view case 2
                Link("Link to Apple website", destination: URL(string: "https://www.apple.com")!)
                    .font(.title)
                    .foregroundColor(.black)
                
                // Link view case 3
                Link(destination: URL(string: "https://www.apple.com")!) {
                    Image(systemName: "link.circle.fill")
                        .font(.largeTitle)
                }
                
                // using the openURL environment key
                Button("Butto to Apple website") {
                    guard let url = URL(string: "https://www.apple.com") else {
                        return
                    }
                    openURL(url)
                }
                
                // using SFSafariViewController
                Button(action: {
                    self.showSFSafariSheet.toggle()
                }, label: {
                    Text("Button to Apple website(SFSafafi)")
                })
                .sheet(isPresented: $showSFSafariSheet, content: {
                    if let url = URL(string: "https://www.apple.com") {
                        SafariView(url: url)
                    }
                })
                
                // uinsg WebKit
                Button(action: {
                    self.showWebKitSheet.toggle()
                }, label: {
                    Text("Button to open WebKit webview")
                })
                .sheet(isPresented: $showWebKitSheet, content: {
                    // TODO: Toolbar does not show and work... need to check in detail.
                    WebKitView()
                })
                //            .fullScreenCover(isPresented: $showSheets, content: {
                //                WebKitView()
                //            })
            }
            .navigationTitle("WebLink Test")
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

struct WebLinkTestView_Previews: PreviewProvider {
    static var previews: some View {
        WebLinkTestView()
    }
}

// MARK: - WebKit View
struct WebKitView: View {
    @StateObject var webviewModel = WebViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    HStack {
                        TextField("Tap an url",
                                  text: $webviewModel.urlString)
                            .keyboardType(.URL)
                            .autocapitalization(.none)
                            .padding(10)
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    
                    Button("Go", action: {
                        webviewModel.request()
                    })
                    .foregroundColor(.white)
                    .padding(10)
                }
                .padding(10)
                
                ZStack {
                    WebView(webview: self.webviewModel.webview)
                    
                    if self.webviewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
            }
        }
        .toolbar(content: {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    webviewModel.back()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.backward")
                })
                .disabled(!webviewModel.canGoBack)
                
                Button(action: {
                    webviewModel.fowrd()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right")
                })
                .disabled(!webviewModel.canGoForward)
                
                Spacer()
            }
        })
    }
}

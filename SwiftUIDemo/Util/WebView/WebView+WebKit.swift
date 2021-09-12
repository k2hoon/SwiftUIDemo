//
//  WebView+WebKit.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/24.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    //typealias UIViewType = WKWebView
    
    let webview: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

//class WebKitNavigationDelegate: NSObject, WKNavigationDelegate {
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        decisionHandler(.allow)
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        decisionHandler(.allow)
//    }
//}

class WebViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    @Published var urlString: String = ""
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isLoading: Bool = false
    
    let webview: WKWebView
    
//    private let delegate: WebKitNavigationDelegate
    
//    init() {
//        let config = WKWebViewConfiguration()
//        config.websiteDataStore = .nonPersistent()
//        self.webview = WKWebView(frame: .zero, configuration: config)
//        self.delegate = WebKitNavigationDelegate()
//        self.webview.navigationDelegate = self.delegate
//    }
    
    override init() {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .nonPersistent()
        self.webview = WKWebView(frame: .zero, configuration: config)
        super.init()
        
        self.webview.navigationDelegate = self
    }
    
    private func bindProperty() -> Void {
        self.webview.publisher(for: \.canGoBack).assign(to: &$canGoBack)
        self.webview.publisher(for: \.canGoForward).assign(to: &$canGoForward)
        self.webview.publisher(for: \.isLoading).assign(to: &$isLoading)
    }
    
    func request() -> Void {
        guard let url = URL(string: urlString) else {
            return
        }
        self.webview.load(URLRequest(url: url))
    }
    
    func fowrd() -> Void {
        self.webview.goForward()
    }
    
    func back() -> Void {
        self.webview.goBack()
    }
    
    // MARK: - WebKitNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}

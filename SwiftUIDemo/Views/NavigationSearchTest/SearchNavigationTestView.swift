//
//  SearchNavigationTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/28.
//

import SwiftUI

struct SearchNavigationTestView: View {
    let sampleData: [String] = ["Apple","Avocado","Banana","Blackberry",
                                "Cherry","Coconut","Dragonfruit","Grapefruit",
                                "Kiwifruit","Lemon","Lime","Mango",
                                "Melon", "Nectarine", "Orange", "Papaya",
                                "Peach", "Pear", "Pineapple", "Raspberry", "Tomato"]
    
    @State var searchString = ""
    
    var body: some View {
        SearchNavigation(text: $searchString, search: search, cancel: cancel) {
            List(self.sampleData, id: \.self) { data in
                Text(data)
            }
            .navigationBarTitle("SearchNavigation")
        }
    }
    
    func search() {
        print("search")
    }
    
    func cancel() {
        print("cancel")
    }
}

struct SearchNavigationTestView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNavigationTestView()
    }
}

struct SearchNavigation<Content: View>: UIViewControllerRepresentable {
    @Binding var text: String
    var search: () -> Void
    var cancel: () -> Void
    var content: () -> Content
    
    func makeCoordinator() -> Coordinator {
        Coordinator(content: content(), searchText: $text, searchAction: search, cancelAction: cancel)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: context.coordinator.rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        context.coordinator.searchController.searchBar.delegate = context.coordinator
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        context.coordinator.update(content: content())
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        let rootViewController: UIHostingController<Content>
        let searchController = UISearchController(searchResultsController: nil)
        var search: () -> Void
        var cancel: () -> Void
        
        init(content: Content, searchText: Binding<String>, searchAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
            rootViewController = UIHostingController(rootView: content)
            searchController.searchBar.autocapitalizationType = .none
            searchController.obscuresBackgroundDuringPresentation = false
            rootViewController.navigationItem.searchController = searchController
            
            _text = searchText
            search = searchAction
            cancel = cancelAction
        }
        
        func update(content: Content) {
            rootViewController.rootView = content
            rootViewController.view.setNeedsDisplay()
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            search()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            cancel()
        }
    }
    
}

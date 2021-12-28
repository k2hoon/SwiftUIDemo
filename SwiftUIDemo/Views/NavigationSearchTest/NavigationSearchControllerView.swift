//
//  NavigationSearchControllerView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/28.
//

import SwiftUI

struct NavigationSearchControllerView: View {
    @State private var searchText: String = ""
    @State private var isSearching = false
    
    let sampleData: [String] = ["Apple","Avocado","Banana","Blackberry",
                                "Cherry","Coconut","Dragonfruit","Grapefruit",
                                "Kiwifruit","Lemon","Lime","Mango",
                                "Melon", "Nectarine", "Orange", "Papaya",
                                "Peach", "Pear", "Pineapple", "Raspberry", "Tomato"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sampleData.filter {
                    self.searchText.isEmpty ? true : $0.contains(self.searchText)
                }, id: \.self) { fruit in
                    Text(fruit)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(
                SearchViewControllerResolver(text: $searchText, isSearch: $isSearching, onCancelButtonClicked: {
                    print("onCancelButtonClicked tapped!")
                    self.isSearching = false
                }, onSearchButtonClicked: {
                    print("onSearchButtonClicked tapped!")
                })
                    .frame(width: 0, height: 0)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationSearchControllerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSearchControllerView()
    }
}

// https://stackoverflow.com/questions/31786050/swift-search-bar-created-at-auto-focus
struct SearchViewControllerResolver: UIViewControllerRepresentable {
    @Binding var text: String
    @Binding var isSearching: Bool
    private let onCancelButtonClicked: () -> Void
    private let onSearchButtonClicked: () -> Void
    
    init(text: Binding<String>,
         isSearch: Binding<Bool>,
         onCancelButtonClicked: @escaping () -> Void = {},
         onSearchButtonClicked: @escaping () -> Void = {}) {
        
        self._text = text
        self._isSearching = isSearch
        self.onCancelButtonClicked = onCancelButtonClicked
        self.onSearchButtonClicked = onSearchButtonClicked
    }
    
    func makeCoordinator() -> Coordinator {
        print("makeCoordinator")
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> NavigationViewResolverController {
        NavigationViewResolverController(resolver: context.coordinator.controller)
    }
    
    func updateUIViewController(_ uiViewController: NavigationViewResolverController, context: Context) {
        print("updateUIViewController")
        if isSearching {
            DispatchQueue.main.async {
                uiViewController.resolver.navigationItem.titleView = context.coordinator.controller.searchBar
                uiViewController.resolver.navigationItem.rightBarButtonItems = nil
                uiViewController.resolver.navigationItem.leftBarButtonItem = nil
                
                DispatchQueue.main.async {
                    context.coordinator.controller.isActive = true
                    context.coordinator.controller.searchBar.becomeFirstResponder()
                }
            }
        } else {
            DispatchQueue.main.async {
                uiViewController.resolver.navigationItem.titleView = nil
                context.coordinator.addLeftBarButtonItemForTitle(uiViewController: uiViewController)
                context.coordinator.addRightBarButtonItems(uiViewController: uiViewController)
            }
        }
    }
    
    // https://dmtopolog.com/navigation-bar-customization/
    class Coordinator: NSObject, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
        let parent: SearchViewControllerResolver
        let controller: UISearchController
        
        init(_ searchViewControllerResolver: SearchViewControllerResolver) {
            print("init")
            self.parent = searchViewControllerResolver
            self.controller = UISearchController(searchResultsController: nil)
            super.init()
            
            self.controller.searchResultsUpdater = self
            self.controller.delegate = self
            self.controller.searchBar.delegate = self
            self.controller.obscuresBackgroundDuringPresentation = false
            self.controller.hidesNavigationBarDuringPresentation = false
            self.controller.searchBar.sizeToFit()
            self.controller.searchBar.text = parent.text
            // not focusing auto...
//            self.controller.isActive = true
//            self.controller.searchBar.becomeFirstResponder()
//            self.controller.searchBar.searchTextField.becomeFirstResponder()
//            self.controller.searchBar.updateFocusIfNeeded()
//            self.controller.isActive = true
//            self.controller.definesPresentationContext = false
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            guard let text = searchController.searchBar.text else { return }
            DispatchQueue.main.async { [weak self] in self?.parent.text = text }
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            DispatchQueue.main.async { self.parent.onCancelButtonClicked() }
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            DispatchQueue.main.async { self.parent.onSearchButtonClicked() }
        }

        
        /// When the search bar is selected, the corresponding method is called.
        /// - Parameter searchController: searchController
        func didPresentSearchController(_ searchController: UISearchController) {
            print("didPresentSearchController")
        }
        
        // MARK: - NavigationBar Item methods.
        func addLeftBarButtonItemForTitle(uiViewController: NavigationViewResolverController) {
            let leftLabel = UILabel()
            leftLabel.text = "hello"
            leftLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(34))
            uiViewController.resolver.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftLabel)
        }
        
        func addRightBarButtonItems(uiViewController: NavigationViewResolverController) {
            let starImage = UIImage(systemName: "star.fill")
            let searchButton = UIBarButtonItem(title: "Search", style: .plain , target: self, action: #selector(didTapSearchButton))
            let helpButton = UIBarButtonItem(title: "Start", style: .plain , target: self, action: #selector(didTapHelpButton))
            let starButton = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(didTapStarImageButton))
            starButton.tintColor = UIColor.black

            uiViewController.resolver.navigationItem.rightBarButtonItems = [starButton, helpButton, searchButton]
        }
        
        @objc public func didTapSearchButton() {
            print("Hello didTapSearchButton")
            self.parent.isSearching.toggle()
        }
        
        @objc public func didTapHelpButton() {
            print("Hello didTapHelpButton")
        }
        
        @objc public func didTapStarImageButton() {
            print("Hello didTapStarImageButton")
        }
    }
}

class NavigationViewResolverController: UIViewController {
    var resolver: UIViewController
    
    init(resolver: UIViewController) {
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(onResolve:) to instantiate NavigationViewResolverController.")
    }
    
    /// Called after the view controller is added or removed from a container view controller
    /// - Parameter parent: The parent view controller, or nil if there is no parent.
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if let parent = parent {
            print("didMove(toParent: \(parent)")
            self.resolver = parent
            //self.resolver.navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    // Create left UIBarButtonItem.
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "RightBtn",
                                     style: .plain,
                                     target: self,
                                     action: #selector(buttonPressed(_:)))
        button.tag = 2
        return button
    }()
    
    // Create back button.
    //    lazy var backButton: UIButton = {
    //        let button = UIButton(frame: CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 100)) button.setTitle("back", for: .normal)
    //        button.backgroundColor = UIColor.brown button.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
    //        return button
    //    }()
    
    // Button event.
    @objc private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
            case 1: // Change the background color to blue. self.view.backgroundColor = .blue
                break
            case 2: // Change the background color to red. self.view.backgroundColor = .red
                break
            default: print("error")
                
            }
        }
    }
    
    @objc private func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

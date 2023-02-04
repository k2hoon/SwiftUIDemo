//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/03/15.
//

import SwiftUI

struct ContentView: View {
    enum ViewType: String, CaseIterable {
        case webLink = "WebLink TestView"
        case attributedString = "AttributedString test"
        case alert = "AlertTestActive test"
        case cacheImage = "Cache Image List test"
        case combine = "CombineTest test"
        case coreData = "Core Data test"
        case json = "JSON test"
        case segment = "Segment picker test"
        case tab = "Tab header test"
        case navigationTab = "Navigation tab test"
        case navigationSearch = "Navigation search test"
        case layout = "Layout test"
        case dataflow = "Data flow test"
                
        func viewBuilder() -> AnyView {
            switch self {
            case .webLink: return AnyView(WebLinkTestView())
            case .attributedString: return AnyView(AttributedStringTestView())
            case .alert: return AnyView(AlertViewTextView())
            case .cacheImage: return AnyView(CachedImageListView())
            case .combine: return AnyView(CombineTestView())
            case .coreData: return AnyView(CoreDataTestView())
            case .json: return AnyView(JsonView())
            case .segment: return AnyView(SegmentPickerTestView())
            case .tab: return AnyView(TabHeaderTestView())
            case .navigationTab: return AnyView(NavigationTabView())
            case .navigationSearch: return AnyView(NavigationSearchTestView())
            case .layout: return AnyView(LayoutTestView())
            case .dataflow: return AnyView(DataFlowTestView())
            }
        }
    }
    
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
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                List {
                    ForEach(ViewType.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.viewBuilder()
                        }
                    }
                }
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


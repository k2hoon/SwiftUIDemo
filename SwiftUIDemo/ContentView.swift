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
        case dataflow2 = "Data flow2 test"
        case gradients = "Gradients Test"
        case mask = "Mask Test"
        case maskLit = "Mask List Test"
        case material = "Material Test"
        case truncaeText = "Truncate Test"
        case tagControl = "Tag Control Test"
        case tagList = "Tag List Test"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .webLink: WebLinkTestView()
            case .attributedString: AttributedStringTestView()
            case .alert: AlertViewTextView()
            case .cacheImage: CachedImageListView()
            case .combine: CombineTestView()
            case .coreData: CoreDataTestView()
            case .json: JsonView()
            case .segment: SegmentPickerTestView()
            case .tab: TabHeaderTestView()
            case .navigationTab: NavigationTabView()
            case .navigationSearch: NavigationSearchTestView()
            case .layout: LayoutTestView()
            case .dataflow: DataFlowTestView()
            case .dataflow2: DataFlowTest2View()
            case .gradients: GradientsView()
            case .mask: MaskView()
            case .maskLit: MaskListView()
            case .material: MaterialView()
            case .truncaeText: TruncatedTextView()
            case .tagControl: TagControlView()
            case .tagList: TagListTestView()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello. This is SwiftUI Collection")
                    .font(.headline)
                    .padding()
                
                Text("Thia app is designed to provide a collection of test views using SwiftUI framework.")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
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
            .navigationViewStyle(.stack)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


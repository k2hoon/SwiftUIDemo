//
//  AdvancedView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct AdvancedView: View {
    
    var body: some View {
        VStack {
            Text("Thia is designed to provide a collection of custom views using SwiftUI framework.")
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
    }
}

struct AdvancedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AdvancedView()
        }
    }
}

extension AdvancedView {
    enum ViewType: String, CaseIterable {
        case attributedString = "AttributedString test"
        case alert = "AlertTestActive test"
        case cacheImage = "Cache Image List test"
        case coreData = "Core Data test"
        case segment = "Segment picker test"
        case tab = "Tab header test"
        case navigationTab = "Navigation tab test"
        case navigationSearch = "Navigation search test"
        case dataflow = "Data flow test"
        case dataflow2 = "Data flow2 test"
        case dataflow3 = "Data flow3 test"
        case truncaeText = "Truncate Test"
        case tagControl = "Tag Control Test"
        case tagList = "Tag List Test"
        case imageZoom = "Image Zoom Test"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .attributedString: AttributedStringTestView()
            case .alert: AlertViewTextView()
            case .cacheImage: CachedImageListView()
            case .coreData: CoreDataTestView()
            case .segment: SegmentPickerTestView()
            case .tab: TabHeaderTestView()
            case .navigationTab: NavigationTabView()
            case .navigationSearch: NavigationSearchTestView()
            case .dataflow: DataFlowTestView()
            case .dataflow2: DataFlow2TestView()
            case .dataflow3: DataFlow3TestView()
            case .truncaeText: TruncatedTextView()
            case .tagControl: TagControlView()
            case .tagList: TagListTestView()
            case .imageZoom: PinchZoomTestView()
            }
        }
    }
}

//
//  BaseView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

//struct FullScreenCover<Content: View>: View {
//    @Binding var isPresented: Bool
//    @ViewBuilder var content: Content
//
//    var body: some View {
//        ZStack {
//            content
//                .environment(\.easyDismiss, EasyDismiss {
//                    isPresented = false
//                })
//        }
//    }
//}
//
//extension View {
//    func easyFullScreenCover<Content>(isPresented: Binding<Bool>, transition: AnyTransition = .opacity, content: @escaping () -> Content) -> some View where Content : View {
//        ZStack {
//            self
//
//            ZStack { // for correct work of transition animation
//                if isPresented.wrappedValue {
//                    FullScreenCover(isPresented: isPresented, content: content)
//                        .transition(transition)
//                }
//            }
//        }
//    }
//}

struct BaseView: View {
    @State var gridLayout = Array(repeating: GridItem(), count: 3)
    @State var selectedItem: ViewType? = nil
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: self.gridLayout, spacing: 8) {
                    ForEach(ViewType.allCases, id: \.self) { item in
                        Button(action: { self.selectedItem = item }) {
                            Text("\(item.rawValue)")
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 120)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.25), radius: 6, x: 4, y: 4)
                        }
                        .fullScreenCover(item: $selectedItem) { item in
                            item.viewBuilder()
                        }
                    }
                }
                .padding(8)
                //
                //                NavigationCollection()
                //
                //                ScrollCollection()
                //
            }
        }
    }
}

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BaseView()
        }
    }
}

extension BaseView {
    enum ViewType: String, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        
        case button = "Button"
        case text = "Text"
        case textField = "TextField"
        case font = "Font"
        case layout = "Layout"
        case scroll = "Scroll"
        case navigation = "Navigation"
        case viewbuilder = "ViewBuiler"
        case geometry = "GeometryReader"
        case dateformar = "DateFormat"
        case weblink = "WebLink"
        case json = "JSON"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .button: ButtonTestView()
            case .text: TextTestView()
            case .textField: TextFieldTestView()
            case .font: FontCollection()
            case .layout: LayoutCollection()
            case .scroll: ScrollCollection()
            case .navigation: NavigationCollection()
            case .viewbuilder: ViewBuilderTestView()
            case .geometry: GeometryReaderTestView()
            case .dateformar: DateFormatterView()
            case .weblink: WebLinkTestView()
            case .json: JsonView()
            }
        }
    }
}

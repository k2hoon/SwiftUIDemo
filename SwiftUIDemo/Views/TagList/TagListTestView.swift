//
//  TagListTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/06.
//

import SwiftUI

struct TagListTestView: View {
    private var tagItems2: [TagItem] = [
        TagItem(key: 0, value: "hello"), TagItem(key: 1, value: "world"),
        TagItem(key: 2, value: "short"), TagItem(key: 3, value: "long"),
        TagItem(key: 4, value: "swift"), TagItem(key: 5, value: "SwiftUI"),
    ]
    @State private var isExpand = false
    @State private var buttonSize: CGSize = .zero
    @State private var scrollAxis: Axis.Set = .horizontal
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                TagList(
                    mode: .scrollable,
                    scrollAxis: $scrollAxis,
                    buttonSize: $buttonSize,
                    items: self.tagItems2) { item in
                        Button(action: {}) {
                            Text("id: \(item.key), value: \(item.value)")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .foregroundColor(Color.gray)
                                )
                        }
                    }
                    .padding(.trailing, self.isExpand ? self.buttonSize.width : 0)
                    .border(.red)
                    .if(self.isExpand == false) { view in
                        view
                            .safeAreaInset(edge: .trailing) { // fade out effect.
                                Button(action: { self.setExpandState() }) {
                                    Image(systemName: "arrow.down.circle")
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                .padding(.leading, 8)
                                .viewSize { size in
                                    self.buttonSize = size
                                }
                                .background {
                                    Color(uiColor: .systemBackground)
                                        .mask {
                                            HStack(spacing: 0) {
                                                LinearGradient(
                                                    stops: [
                                                        Gradient.Stop(color: .clear, location: .zero),
                                                        Gradient.Stop(color: .black, location: 1.0)
                                                    ],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                                
                                                Color.black
                                            }
                                        }
                                        .padding(.horizontal, -8) // set the value the samee as button padding.
                                }
                            }
                    }
                
                if self.isExpand {
                    Button(action: { self.setExpandState() }) {
                        Image(systemName: "arrow.up.circle")
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
        }
    }
    
    func setExpandState() {
        self.scrollAxis = self.scrollAxis == .vertical ? .horizontal : .vertical
        self.isExpand.toggle()
    }
}

extension TagListTestView {
    struct TagItem: Hashable {
        var key: Int
        var value: String
    }
}

struct TagList<T: Hashable, V: View>: View {
    enum Mode {
        case scrollable, vstack
    }
    
    let mode: Mode
    @Binding var scrollAxis: Axis.Set
    @Binding var buttonSize: CGSize
    let items: [T]
    let viewMapping: (T) -> V
    
    @State var totalHeight: CGFloat = .zero
    
    init(mode: Mode,
         scrollAxis: Binding<Axis.Set>,
         buttonSize: Binding<CGSize>,
         items: [T],
         viewMapping: @escaping (T) -> V) {
        self.mode = mode
        self.items = items
        self.viewMapping = viewMapping
        _scrollAxis = scrollAxis
        _buttonSize = buttonSize
        _totalHeight = State(initialValue: (mode == .scrollable) ? .zero : .infinity)
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                if scrollAxis == .vertical {
                    ScrollView(.vertical) {
                        self.verticalContents(in: geometry)
                    }
                    .scrollEnabled(false)
                    
                } else {
                    ScrollView(.horizontal, showsIndicators: true) {
                        self.horizontalContents(in: geometry)
                    }
                    .frame(height: self.buttonSize.height)
                }
            }
        }
        .frame(height: scrollAxis == .vertical ? self.totalHeight : self.buttonSize.height)
    }
    
    private func horizontalContents(in geomerty: GeometryProxy) -> some View {
        LazyHStack {
            ForEach(self.items, id: \.self) { item in
                self.viewMapping(item)
            }
        }
    }
    
    private func verticalContents(in geomerty: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.items, id: \.self) { item in
                self.viewMapping(item)
                    .padding([.horizontal, .vertical], 8)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > geomerty.size.width) {
                            width = 0
                            height -= d.height
                        }
                        
                        let result = width
                        if item == self.items.last {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if item == self.items.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .global)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TagListTestView_Previews: PreviewProvider {
    static var previews: some View {
        TagListTestView()
    }
}

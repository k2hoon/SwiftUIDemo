//
//  RefreshAsyncCarouselList.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/19.
//

import SwiftUI
import Combine

class RefreshAsyncCarouselViewModel: ObservableObject {
    enum LoadResult: String, CaseIterable, CustomStringConvertible {
        case loaded
        case empty
        case error
        
        var description: String { rawValue.capitalized }
    }
    
    class FakePostService {
        static let sampleItem = (1...5).map { Post(name: "imagePost\($0)") }
        static let error = URLError(.badServerResponse)
        var result: Result<[Post], Error> = .success(Post.placeholders)
        
        func getPostCards() -> AnyPublisher<[Post], Error> {
            result.publisher.eraseToAnyPublisher()
        }
    }
    
    @Published private(set) var loadState: AsnycContentsState<[Post]> = .loading(placeholder: Post.placeholders)
    @Published var loadResult: LoadResult = .loaded
    
    private var subscriptions = Set<AnyCancellable>()
    private var reloadSubject = PassthroughSubject<Void, Never>()
    
    init() {
        let fakeService = FakePostService()
        
        self.$loadResult.sink { [reloadSubject] value in
            switch value {
            case .error: fakeService.result = .failure(FakePostService.error)
            case .loaded: fakeService.result = .success(FakePostService.sampleItem)
            case .empty: fakeService.result = .success([])
            }
            reloadSubject.send()
        }
        .store(in: &subscriptions)
        
        self.reloadSubject
            .map {
                fakeService
                    .getPostCards()
                    .delay(for: .seconds(2), scheduler: DispatchQueue.main)
                    .mapToLoadingState(placeholder: Post.placeholders)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: \.loadState, on: self)
            .store(in: &subscriptions)
    }
    
    func reload() {
        self.reloadSubject.send()
    }
}

struct Post: Identifiable {
    var id = UUID().uuidString
    var name: String
    
    static let placeholders: [Self] = (1...5).map {
        .init(name: "imagePost\($0)")
    }
}

struct RefreshAsyncCarouselList: View {
    @State var currentIndex = 0
    @State var topOffset: CGFloat = 0
    @Namespace var animation
    @StateObject var viewModel = RefreshAsyncCarouselViewModel()
    
    @State var updateOffset: CGFloat = 0
    @State var changeOffset: CGFloat = 0
    @State var endOffset: CGFloat = 0
    
    var isRefreshable: Bool {
        if case .empty = self.viewModel.loadState {
            return true
        } else if self.currentIndex == 0 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                let topEdge = proxy.safeAreaInsets.top
                
                VStack(spacing: 15) {
                    // top
                    VStack {
                        TitleBack(title: "Refresh async carousel", spacing: 12) {
                            // TODO: something
                        }
                        .frame(height: 70)
                        .padding()
                        
                        HStack {
                            Button("Reload", action: { self.viewModel.reload() })
                            Button("Empty", action: { self.viewModel.loadResult = .empty })
                            Button("Error", action: { self.viewModel.loadResult = .error })
                        }
                    }
                    .viewSize { size in
                        self.topOffset = size.height
                    }
                    
                    RefreshGestureView(
                        isRefreshable: self.isRefreshable,
                        onUpdate: { update in self.updateOffset = update },
                        onChanged: { offset in self.changeOffset = offset },
                        onEnded: { offset in self.endOffset = offset },
                        onRefresh: { try? await Task.sleep(nanoseconds: 1_500_000_000) },
                        content: {
                            AsyncContentsList(
                                loadingState: viewModel.loadState,
                                content: { posts in
                                    VCarouselList(
                                        updateOffset: $updateOffset,
                                        changeOffset: $changeOffset,
                                        endOffset: $endOffset,
                                        index: $currentIndex,
                                        spacing: 12,
                                        trailingSpace: 100,
                                        items: posts) { post in
                                            PostCardView(post: post, topOffset: topOffset + topEdge + 15)
                                        }
                                },
                                empty: {
                                    EmptyView(topOffset: topOffset + topEdge + 15)
                                },
                                error: { _ in
                                    Text("error")
                                }
                            )
                            .padding(.horizontal, 20)
                            .onAppear {
                                self.viewModel.reload()
                            }
                        }
                    )
                }
            }
        }
    }
    
    struct EmptyView: View {
        var topOffset: CGFloat
        
        var body: some View {
            GeometryReader { proxy in
                let size = proxy.size
                
                // scaling and opacity effect
                let minY = proxy.frame(in: .global).minY - topOffset
                let progress = -minY / size.height
                let scale = 1 - (progress / 3)
                
                ZStack{
                    Color.green
                    VStack {
                        Text("empty")
                    }
                    .frame(width: size.width, height: size.height)
                }
                .scaleEffect(minY < 0 ? scale : 1)
                .offset(y: minY < 0 ? -minY : 0)
            }
        }
    }
    
    // PostCardView
    struct PostCardView: View {
        var post: Post
        var topOffset: CGFloat
        
        var body: some View {
            // to get size of image
            GeometryReader { proxy in
                let size = proxy.size
                
                // scaling and opacity effect
                let minY = proxy.frame(in: .global).minY - topOffset
                let progress = -minY / size.height
                let scale = 1 - (progress / 3)
                let opacity = 1 - progress
                
                ZStack {
                    Image(post.name)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(15)
                }
                .scaleEffect(minY < 0 ? scale : 1)
                .opacity(minY < 0 ? opacity : 1)
                // stopping view when y value goes < 0
                .offset(y: minY < 0 ? -minY : 0)
            }
        }
    }
    
    // RefreshGestureView
    struct RefreshGestureView<Content>: View where Content: View {
        @GestureState var offset: CGFloat = 0
        @State private var currentIndex: Int = 0
        @State private var progress: CGFloat = 0
        @State private var isEligible = false
        @State private var isRefresh = false
        @State private var lastIndex = 0
        
        var isRefreshable: Bool
        let onUpdate: (CGFloat) -> Void
        let onChanged: (CGFloat) -> Void
        let onEnded: (CGFloat) -> Void
        var onRefresh: () async -> ()
        let content: () -> Content // the ScrollView content
        
        private let THRESHOLD: CGFloat = 150
        private let indicatorHeight: CGFloat = 50
        
        var dragGesture: some Gesture {
            DragGesture()
                .updating($offset, body: { value, out, transaction in
                    out = value.translation.height
                    self.onUpdate(offset)
                })
                .onEnded({ value in
                    let offsetY = value.translation.height
                    self.onEnded(offsetY)
                    self.onUpdate(0)
                    if self.isRefreshable {
                        if !isRefresh {
                            if offsetY > THRESHOLD {
                                self.isEligible = true
                            } else {
                                self.isEligible = false
                                self.progress = 0
                            }
                        }
                        
                        if isEligible && !isRefresh {
                            self.isRefresh = true
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    }
                })
                .onChanged({ value in
                    let offsetY = value.translation.height
                    self.onChanged(offsetY)
                    if offsetY > 0 && isRefreshable {
                        let drag = offsetY / THRESHOLD
                        self.progress = (drag < 0 ? 0 : drag)
                        self.progress = (drag > 1 ? 1 : drag)
                    }
                })
        }
        
        var body: some View {
            GeometryReader { proxy in
                let size = proxy.size
                let minY = proxy.frame(in: .global).minY
                let progressY = -minY / size.height
                
                ZStack(alignment: .top) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: isRefresh ? 0 : THRESHOLD * progress)
                        
                        ActivityIndicator(isAnimating: isRefresh, color: .white) {
                            $0.hidesWhenStopped = false
                        }
                    }
                    .opacity(progress)
                    .zIndex(1)
                    
                    content()
                        .onChange(of: self.isRefresh) { newValue in
                            if newValue {
                                Task {
                                    await onRefresh()
                                    withAnimation(.easeInOut) {
                                        self.progress = 0
                                        self.isEligible = false
                                        self.isRefresh = false
                                    }
                                }
                            }
                        }
                        .alignmentGuide(.top) { _ in
                            isEligible ? -indicatorHeight : 0
                        }
                        .gesture(self.dragGesture)
                }
            }
        }
    }
    
    // VCarouselList
    struct VCarouselList<Content: View, T: Identifiable>: View {
        @Binding var updateOffset: CGFloat
        @Binding var changeOffset: CGFloat
        @Binding var endOffset: CGFloat
        @Binding var index: Int
        
        var spacing: CGFloat = 15
        var trailingSpace: CGFloat = 100
        var items: [T]
        var content: (T) -> Content
        
        // offset
        @State var offset: CGFloat = 0
        @State var currentIndex: Int = 0
        @State var lastIndex = 0
        
        var body: some View {
            GeometryReader { proxy in
                let height = proxy.size.height - (trailingSpace - spacing)
                let adjustMentHeight: CGFloat = 0
                
                VStack(spacing: spacing) {
                    ForEach(self.items) { item in
                        self.content(item)
                            .frame(height: proxy.size.height - trailingSpace)
                    }
                }
                .offset(y: (CGFloat(currentIndex) * -height) + (currentIndex != 0 ? adjustMentHeight : 0) + offset)
                .onChange(of: self.updateOffset) { value in
                    offset = value
                }
                .onChange(of: self.changeOffset) { value in
                    let progress = -value / height
                    let roundIndex = progress.rounded()
                    lastIndex = max(min(currentIndex + Int(roundIndex), self.items.count - 1), 0)
                }
                .onChange(of: self.endOffset) { value in
                    let progress = -value / height
                    let roundIndex = progress.rounded()
                    currentIndex = max(min(currentIndex + Int(roundIndex), self.items.count - 1), 0)
                    index = currentIndex
                }
            }
            .animation(.easeInOut, value: offset == 0)
        }
    }
    
    struct ActivityIndicator: UIViewRepresentable {
        typealias UIView = UIActivityIndicatorView
        
        var isAnimating: Bool = true
        var color: Color
        var configuration = { (indicator: UIView) in }
        
        init(isAnimating: Bool, color: Color, configuration: ((UIView) -> Void)? = nil) {
            self.isAnimating = isAnimating
            self.color = color
            if let configuration = configuration {
                self.configuration = configuration
            }
        }
        
        func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView {
            let view = UIView()
            view.color = self.color.toUIColor()
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
            isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
            configuration(uiView)
        }
    }
}

struct RefreshAsyncCarouselList_Previews: PreviewProvider {
    static var previews: some View {
        RefreshAsyncCarouselList()
    }
}

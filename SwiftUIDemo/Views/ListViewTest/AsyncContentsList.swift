//
//  ContentsAsnycList.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI
import Combine

extension Publisher where Output: Collection {
    func mapToLoadingState(placeholder: Output) -> AnyPublisher<AsnycContentsState<Output>, Never> {
        map {
            $0.isEmpty ? AsnycContentsState.empty : .loaded(content: $0)
        }
        .catch {
            Just(AsnycContentsState.error($0))
        }
        .prepend(.loading(placeholder: placeholder))
        .eraseToAnyPublisher()
    }
}

public enum AsnycContentsState<Content> {
    case loading(placeholder: Content)
    case loaded(content: Content)
    case empty
    case error(Error)
}

struct AsyncContentsList<Item, Content: View, EmptyView: View, ErrorView: View>: View {
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))
    private let state: AsnycContentsState<[Item]>
    private let makeContent: ([Item]) -> Content
    private let makeEmpty: () -> EmptyView
    private let makeError: (Error) -> ErrorView
    
    init(loadingState: AsnycContentsState<[Item]>,
         @ViewBuilder content: @escaping ([Item]) -> Content,
         @ViewBuilder empty: @escaping () -> EmptyView,
         @ViewBuilder error: @escaping (Error) -> ErrorView) {
        state = loadingState
        makeContent = content
        makeEmpty = empty
        makeError = error
    }
    
    var body: some View {
        switch state {
        case let .loading(placeholders):
            makeContent(placeholders)
                .redacted(reason: .placeholder)
                .shimmer()
                .disabled(true)
                .transition(fade)
        case let .loaded(items):
            makeContent(items)
                .transition(fade)
        case .empty:
            makeEmpty()
                .transition(fade)
        case let .error(error):
            makeError(error)
                .transition(fade)
        }
    }
}

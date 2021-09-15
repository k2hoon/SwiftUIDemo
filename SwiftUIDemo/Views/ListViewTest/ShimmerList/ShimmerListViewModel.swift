//
//  ShimmerListViewModel.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import Foundation
import Combine

struct UserInfoItem: Codable, Identifiable {
    var id: Int
    var username: String
    var title: String
    var description: String
    var systemName: String
    
    static let placeholders: [Self] = (0..<10).map {
        .init(id: $0,
              username: "hello, world",
              title: "Lorem ipsum dolor",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              systemName: "list.bullet")
    }
}

class FakeUserInfoService {
    static let sampleItem: [UserInfoItem] = {
        Bundle.main.url(forResource: "UserInfo", withExtension: "json")
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { try? JSONDecoder().decode([UserInfoItem].self, from: $0)} ?? []
    }()
    static let error = URLError(.badServerResponse)
    var result: Result<[UserInfoItem], Error> = .success(sampleItem)
    
    func getFeed() -> AnyPublisher<[UserInfoItem], Error> {
        result.publisher.eraseToAnyPublisher()
    }
}

class ShimmerListViewModel: ObservableObject {
    enum UserInfoResult: String, CaseIterable, CustomStringConvertible {
        var description: String { rawValue.capitalized }
        case loaded
        case empty
        case error
    }
    
    @Published private(set) var loadingState: AsnycContentsState<[UserInfoItem]> = .loading(placeholder: UserInfoItem.placeholders)
    @Published var userInfoResult: UserInfoResult = .loaded
    
    private var subscriptions = Set<AnyCancellable>()
    private var reloadSubject = PassthroughSubject<Void, Never>()
    
    init() {
        let fakeUserInfo = FakeUserInfoService()
        $userInfoResult.sink { [reloadSubject] value in
            switch value {
            case .error:
                fakeUserInfo.result = .failure(FakeUserInfoService.error)
            case .loaded:
                fakeUserInfo.result = .success(FakeUserInfoService.sampleItem)
            case .empty:
                fakeUserInfo.result = .success([])
            }
            reloadSubject.send()
        }
        .store(in: &subscriptions)
        
        reloadSubject
            .map {
                fakeUserInfo
                    .getFeed()
                    .delay(for: .seconds(2), scheduler: DispatchQueue.main)
                    .mapToLoadingState(placeholder: UserInfoItem.placeholders)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: \.loadingState, on: self)
            .store(in: &subscriptions)
    }
    
    func reload() -> Void {
        reloadSubject.send()
    }
}

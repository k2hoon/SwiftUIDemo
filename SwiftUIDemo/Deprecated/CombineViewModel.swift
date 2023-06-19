//
//  CombineViewModel.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/02.
//

import Foundation
import Combine

struct UserItem {
    var name: String
}

class UserItemList {
    @Published private(set) var userItem: [UserItem] = []
    
    func addUserItem(name: String) -> Void {
        self.userItem.append(UserItem(name: name))
    }
}

//class CombineTester {
//    init() {
//        let john = CombineViewModel(name: "John Appleseed", age: 24)
//
//    }
//}

enum SubjectError: Error {
    case test
}

final class StringSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = SubjectError
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received value", input)
        return input == "World" ? .max(1) : .none
    }
    
    func receive(completion: Subscribers.Completion<SubjectError>) {
        print("Received completion", completion)
    }
}

class CombineViewModel: ObservableObject {
    //@Published var value = 0
    @Published var progressValue = 0.25
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var notified = ""
    
    init() {
        for i in 0...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
    
    func increaseProgress() -> Void {
        progressValue += 0.1
    }
    
    func sampleCurrentValueSubject() -> Void {
        var subscriptions = Set<AnyCancellable>()
        let subject = CurrentValueSubject<Int, Never>(0)
        
        subject
            .print()
            .sink {
                print($0)
            }
            .store(in: &subscriptions)
        
        subject.send(1)
        subject.send(2)
        
        //print(subject.value)
        
        subject.value = 3
        //print(subject.value)
        
        subject
            .print()
            .sink(receiveValue: { print("Second subscription:", $0) })
            .store(in: &subscriptions)
        
        subject.send(completion: .finished)
    }
    
    func sampleSubject() -> Void {
        let subscriber = StringSubscriber()
        let subject = PassthroughSubject<String, SubjectError>()
        subject.subscribe(subscriber)
        
        let subscription = subject.sink { completion in
            print("Received completion (sink)", completion)
        } receiveValue: { value in
            print("Received value (sink)", value)
        }
        
        subject.send("Hello")
        subject.send("World")
        
        subscription.cancel()
        subject.send("Still there?")
        
        subject.send(completion: .failure(SubjectError.test))
        
        subject.send(completion: .finished)
        subject.send("How about another one?")
        
        
    }
    
    func sampleJust() -> Void {
        let just = Just("Hello Just!")
        
        _ = just.sink(receiveCompletion: {
            print("received completion", $0)
        }, receiveValue: {
            print("received value", $0)
        })
        
        _ = just.sink(receiveCompletion: {
            print("received completion (2)", $0)
        }, receiveValue: {
            print("received value (2)", $0)
        })
    }
    //    @Published var name: String
    //    @Published var age: Int
    //
    //    init(name: String, age: Int) {
    //        self.name = name
    //        self.age = age
    //    }
    //
    //    func haveBirthday() -> Int {
    //        age += 1
    //        return age
    //    }
    //
    //    let list = UserItemList()
    //
    //    func test() -> Void {
    //
    //    }
    
    //    let allItemSubscription = list.$userItem.sink { items in
    //        //
    //
    //    }
    
    //    let firstItemSubscription = list.$userItem.compactMap(\.first).sink { item in
    //
    //    }
    
    //    init() {
    //
    //    }
    
    //@Published var count = 0
    //    var count: Int = 0 {
    //        willSet(value) {
    //            objectWillChange.send()
    //        }
    //    }
    
    
}

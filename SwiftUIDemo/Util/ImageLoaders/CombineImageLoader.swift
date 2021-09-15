//
//  CombineImageLoader.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import Foundation
import SwiftUI
import Combine

class CombineImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var error: Error?
    
    private(set) var isLoading = false
    private var cancellable: AnyCancellable?
    private static let imageProcessQueue = DispatchQueue(label: "image-process")
    private var cache: ImageCache?
    
    init(cache: ImageCache? = nil) {
        self.cache = cache
    }
    
    deinit {
        self.cancel()
    }
    
    func loadSubcribe(urlString: String) -> Void {
        if isLoading {
            return
        }
        //guard !isLoading else { return }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map({ data, response in
                UIImage(data: data)
            })
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.start()
            }, receiveOutput: { [weak self] uiImage in
                self?.cache(url: url, uiImage)
            }, receiveCompletion: { [weak self] _ in
                self?.finish()
            }, receiveCancel: { [weak self] in
                self?.finish()
            })
            .subscribe(on: Self.imageProcessQueue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.image = $0
            })
        
    }
    
    private func start() -> Void {
        isLoading = true
    }
    
    private func finish() -> Void {
        isLoading = false
    }
    
    private func cancel() -> Void {
        cancellable?.cancel()
    }
    
    private func cache(url: URL, _ image: UIImage?) -> Void {
        image.map { uiImage in
            cache?[url] = uiImage
        }
    }
}

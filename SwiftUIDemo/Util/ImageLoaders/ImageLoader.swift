//
//  ImageLoader.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var error: Error?
    var urlString: String = ""
    
    // image caching using nscache
    var imageCache = ImageCaching.shared
    
    func load(urlString: String) -> Void {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(String(describing: error))")
                DispatchQueue.main.async {
                    self.error = error
                    return
                }
            }
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    self.image = UIImage(systemName: "exclamationmark.triangle")
                    return
                }
                self.image = image
            }
        }
        task.resume()
    }
    
    func loadWithUrlCache(urlString: String) -> Void {
        self.urlString = urlString
        guard let url = URL(string: urlString) else {
            return
        }
        
        let cache = URLCache.shared
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let cachedData = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: cachedData)
        } else {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.error = error
                        return
                    }
                }
                
                guard let data = data, let response = response else {
                    return
                }
                
                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        
    }
    
    func loadWithCache(urlString: String) -> Void {
        self.urlString = urlString
        if loadImageFromCache() {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(String(describing: error))")
                DispatchQueue.main.async {
                    self.error = error
                    return
                }
            }
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    self.image = UIImage(systemName: "exclamationmark.triangle")
                    return
                }
                self.imageCache.set(for: self.urlString, image: image)
                self.image = image
            }
        }
        task.resume()
    }
    
    private func loadImageFromCache() -> Bool {
        guard let cachedImage = imageCache.get(for: urlString) else {
            return false
        }
        
        self.image = cachedImage
        return true
    }
    
}

//
//  EnvironmentValues+ImageCache.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import Foundation

import SwiftUI


// MARK: - EnvironmentValues+ImageCache
struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}


struct TemporaryImageCache: ImageCache {
    subscript(url: URL) -> UIImage? {
        get {
            cache.object(forKey: url as NSURL)
        }
        set {
            newValue == nil ? cache.removeObject(forKey: url as NSURL) : cache.setObject(newValue!, forKey: url as NSURL)
        }
    }
    
    private let cache = NSCache<NSURL, UIImage>()
}

class ImageCaching {
    static let shared: ImageCaching = {
       let instance = ImageCaching()
        return instance
    }()
    
    var cache = NSCache<NSString, UIImage>()
    
    func get(for key: String) -> UIImage? {
        print("Load cached: ", key)
                return cache.object(forKey: key as NSString)
    }
    
    func set(for key: String, image: UIImage) -> Void {
        print("Set cache: ", key)
                cache.setObject(image, forKey: key as NSString)
    }
}

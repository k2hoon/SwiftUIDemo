//
//  CarouselList+Model.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/10.
//

import Foundation

extension CarouselList {
    struct Post: Identifiable {
        var id = UUID().uuidString
        var name: String
    }
}

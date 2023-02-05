//
//  DataFlowViewModel.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/02/05.
//

import Foundation

class DataFlowViewModel: ObservableObject {
    @Published var firstValue = 0
    @Published var secondValue = 0
    @Published var isEnabled = false
}

//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/03/15.
//

import SwiftUI

@main
struct SwiftUIDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

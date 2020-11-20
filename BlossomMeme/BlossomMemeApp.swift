//
//  BlossomMemeApp.swift
//  BlossomMeme
//
//  Created by yuhan yin on 11/20/20.
//

import SwiftUI

@main
struct BlossomMemeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

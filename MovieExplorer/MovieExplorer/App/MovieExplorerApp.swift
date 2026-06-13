//
//  MovieExplorerApp.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import SwiftUI
import SwiftData

@main
struct MovieExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [
            RecentlyViewedEntity.self
        ])
    }
}




//
//  MovieExplorerApp.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import SwiftUI

@main
struct MovieExplorerApp: App {
    @State private var container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            MovieListView(
                viewModel: container.makeMovieListViewModel()
            )
            .environment(container)
        }
    }
}

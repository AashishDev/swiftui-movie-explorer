//
//  RootView.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        let container = AppContainer(modelContext: modelContext)

        MovieListView(
            viewModel: container.makeMovieListViewModel()
        )
        .environment(container)
    }
}

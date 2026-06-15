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
    @State private var container: AppContainer?

    init() {
          print("✅ RootView init")
      }
    
    var body: some View {

        Group {
            if let container {
                MovieListView(
                    viewModel: container.makeMovieListViewModel()
                )
                .environment(container)
            } else {
                LaunchView()
            }
        }
        .task {
            if container == nil {
                container = AppContainer(
                    modelContext: modelContext
                )
            }
        }
    }
}

//
//  MovieCellView.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import SwiftUI

struct MovieDetailView: View {
    @State var viewModel: MovieDetailViewModel

    var body: some View {

        content
            .navigationTitle(UIConstants.Title.movieDetail)
            .task {
                guard viewModel.state == .idle else { return}
                await viewModel.load()
            }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .idle,
             .loading:
            ProgressView()

        case .loaded(let movie):
            List {
                LabeledContent(
                    "Title",
                    value: movie.title
                )

                LabeledContent(
                    "Rating",
                    value:
                        movie.rating
                )

                Section("Description") {
                    Text(movie.description)
                }
            }

        case .error(let error):

            ErrorStateView(
                message: error.message
            ) {
                Task {
                    await viewModel.load()
                }
            }
        }
    }
}

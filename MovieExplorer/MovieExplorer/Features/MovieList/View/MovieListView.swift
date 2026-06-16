//
//  MovieListView.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import SwiftUI

struct MovieListView: View {
    @State var viewModel: MovieListViewModel
    @Environment(AppContainer.self) private var container
    
    var body: some View {
        @Bindable var router = container.router
        
        NavigationStack(path:$router.path) {
            content
                .navigationTitle(UIConstants.Title.movies)
                .navigationDestination(for:AppRoute.self) { route in
                    switch route {
                    case .movieDetails(let movieId):
                        MovieDetailView(
                            viewModel:container.makeMovieDetailViewModel(for: movieId))
                    }
                }
        }
        .refreshable {
            await viewModel.refresh()
        }
        .task {
            if viewModel.state == .idle {
                await viewModel.load()
            }
        }
        .onChange(of: container.router.path) { _, _ in
            Task {
                await viewModel.loadRecentlyViewed()
            }
        }
    }
    
    // MARK: - Content
    @ViewBuilder
    private var content: some View {
        
        switch viewModel.state {
            
        case .idle, .loading:
            ProgressView(UIConstants.ProgressView.msg)
            
        case .loaded(let movies):
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    if let msg = viewModel.refreshErrorMessage {
                        Text(msg)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.horizontal)
                    }
                    
                    
                    // Recently Viewed items [From Swift data]
                    if !viewModel.recentlyViewed.isEmpty {
                        recentlyViewedSection
                        Divider()
                    }
                    
                    //Movie List SECTION
                    movieListSection(movies)
                }
            }
            
        case .error(let error):
            ErrorStateView(
                message: error.message,
                retryAction: {
                    Task { await viewModel.load() }
                }
            )
        }
    }
    
    // MARK: - Recently Viewed Section
    private var recentlyViewedSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(UIConstants.Title.recentlyViewed)
                    .font(.headline)
                Spacer()
                
                Button {
                    Task {
                        await viewModel.clearRecentlyViewed()
                    }
                } label: {
                    Image(systemName: UIConstants.Images.deleteIcon)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 8) {
                    ForEach(viewModel.recentlyViewed) { item in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(item.title)
                                .font(.headline)
                                .lineLimit(1)
                                .frame(width: 150, alignment: .leading)
                            
                            Text(item.displayDate)
                                .font(.caption)
                                .lineLimit(1)
                                .frame(width: 120, alignment: .leading)
                        }
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Movie List Section
    private func movieListSection(_ movies: [Movie]) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(UIConstants.Title.popularMovies)
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(movies) { movie in
                Button {
                    container.router.push(
                        .movieDetails(id: movie.id)
                    )
                } label: {
                    MovieCellView(movie: movie)
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                Divider()
            }
        }
    }
}



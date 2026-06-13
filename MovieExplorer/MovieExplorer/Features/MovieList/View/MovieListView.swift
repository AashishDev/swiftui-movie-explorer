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
                .navigationTitle("Movies")
                .navigationDestination(for:AppRoute.self) { route in
                    switch route {
                    case .movieDetails(let movieId):
                        MovieDetailView(movieId: movieId)
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
    }
    
    @ViewBuilder
    private var content: some View {
        
        switch viewModel.state {
        case .idle,.loading:
            ProgressView("Loading Movies...")
            
        case .loaded(let movies):
            List(movies) { movie in
                NavigationLink(destination: Text("DetailView")) {
                    MovieCellView(movie: movie)
                }
            }
            
        case .error(let error):
            ErrorStateView(message: error.message,retryAction: {
                Task {
                    await viewModel.load()
                }
            }
            )
        }
    }
}


#Preview {
    NavigationView {
        //MovieListView(viewModel: <#MovieListViewModel#>)
    }
}

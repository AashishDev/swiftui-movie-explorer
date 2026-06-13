//
//  MovieListView.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//
import SwiftUI

struct MovieListView: View {
    
    @State var viewModel: MovieListViewModel
    
    var body: some View {
        
        NavigationStack {
            content
                .navigationTitle("Movies")
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

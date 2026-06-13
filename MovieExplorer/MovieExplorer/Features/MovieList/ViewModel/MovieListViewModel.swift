//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import SwiftUI

enum MovieListState:Equatable {
    case idle
    case loading
    case loaded([Movie])
    case error(APIError)
}

@MainActor
@Observable
final class MovieListViewModel {
    
    private(set) var state: MovieListState = .idle
    var isRefreshing = false
    
    private let fetchMoviesUseCase: FetchMoviesUseCase
    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }
    
    func load() async {
        state = .loading
      //  defer { state = .idle }
        do {
            let movies =  try await fetchMoviesUseCase.execute()
            state = .loaded(movies)
        } catch {
            state =  .error(APIError.serverError(error))
        }
    }
    
    func refresh() async {
        isRefreshing = true
        defer { isRefreshing = false }
        
        do {
            let movies =  try await fetchMoviesUseCase.execute()
            state =  .loaded(movies)
        }
        catch {
            state =  .error(APIError.serverError(error))
        }
    }
}

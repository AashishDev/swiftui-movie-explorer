//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Observation

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
    
    private let useCase: FetchMoviesUseCase
    init(useCase: FetchMoviesUseCase) {
        self.useCase = useCase
    }
    
    func load() async {
        state = .loading
        do {
            let movies =  try await useCase.execute()
            state = .loaded(movies)
        } catch {
            state =  .error(APIError.serverError(error))
        }
    }
    
    func refresh() async {
        isRefreshing = true
        defer { isRefreshing = false }
        
        do {
            let movies =  try await useCase.execute()
            state =  .loaded(movies)
        }
        catch {
            state =  .error(APIError.serverError(error))
        }
    }
}

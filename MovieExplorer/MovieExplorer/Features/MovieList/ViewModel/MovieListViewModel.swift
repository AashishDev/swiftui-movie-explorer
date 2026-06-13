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
    private(set) var recentlyViewed: [RecentlyViewedMovie] = []
    
    private let useCase: FetchMoviesUseCase
    private let recentlyViewedUseCase: RecentlyViewedUseCaseProtocol
    
    init(useCase: FetchMoviesUseCase,recentlyViewedUseCase: RecentlyViewedUseCaseProtocol) {
        self.useCase = useCase
        self.recentlyViewedUseCase = recentlyViewedUseCase
    }
    
    func load() async {
        state = .loading
        do {
            let movies =  try await useCase.execute()
            state = .loaded(movies)
            await loadRecentlyViewed()
            
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
            await loadRecentlyViewed()
        }
        catch {
            state =  .error(APIError.serverError(error))
        }
    }
}

extension MovieListViewModel {
    
    func loadRecentlyViewed() async {
        do {
            recentlyViewed = try await recentlyViewedUseCase.fetch(limit: 10)
        } catch {
            print("Failed to load recently viewed: \(error)")
        }
    }
    
    func clearRecentlyViewed() async {
        do {
            try await recentlyViewedUseCase.clearAll()
            recentlyViewed = []
        } catch {
            print("Failed to clear recently viewed: \(error)")
        }
    }
}
